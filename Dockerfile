# Dockerfile
# R/Python, Pandoc, Quarto, and key R packages

FROM rocker/r-ver:4.4.2

ENV DEFAULT_USER="ruser"
ENV S6_VERSION="v2.1.0.2"
ENV PANDOC_VERSION="3.1.11.1"
ENV QUARTO_VERSION="1.6.39"

RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    perl-modules \
    python3 \
    pip \
    sudo \
    openssh-client \
    git \
    curl

RUN /rocker_scripts/install_pandoc.sh
RUN /rocker_scripts/install_quarto.sh
RUN /rocker_scripts/default_user.sh $DEFAULT_USER

RUN usermod -aG sudo ${DEFAULT_USER} && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER $DEFAULT_USER

# Install radian and jupyter for R/ Python
RUN pip3 install -U radian
RUN pip3 install -U jupyter

# Include .Rprofile with default CRAN mirror
# and set renv to install using {pak}
COPY .Rprofile /home/${DEFAULT_USER}/.Rprofile

RUN R -q -e "install.packages(c('pak', 'tinytex', 'renv', 'knitr', 'rmarkdown', 'languageserver'), repos = c('https://cloud.r-project.org/', 'https://r-lib.r-universe.dev'));" \
    && R -q -e "tinytex::install_tinytex(force = TRUE)"

# Source ~/.profile and start bash
CMD ["bash", "-c", "source ~/.profile && exec bash"]
