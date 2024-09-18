# Dockerfile
# R, Pandoc, Quarto, and key R packages

FROM rocker/r-ver:4.4.1

ENV DEFAULT_USER="ruser"
ENV S6_VERSION="v2.1.0.2"
ENV PANDOC_VERSION="3.1.11.1"
ENV QUARTO_VERSION="1.5.56"

RUN apt-get update && apt-get install -y \
    perl-modules \
    libcurl4-openssl-dev \
    sudo

RUN /rocker_scripts/install_pandoc.sh && /rocker_scripts/install_quarto.sh

RUN /rocker_scripts/default_user.sh $DEFAULT_USER

RUN usermod -aG sudo ${DEFAULT_USER} && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER $DEFAULT_USER

RUN R -q -e "install.packages(c('pak', 'tinytex', 'renv', 'knitr', 'rmarkdown'), repos = c('https://cloud.r-project.org/', 'https://r-lib.r-universe.dev'));" \
    && R -q -e "tinytex::install_tinytex(dir = '~/.local/bin/')"

RUN rm -rf ~/bin

CMD ["bash"]