# qtalr-r base image

This repo contains the Dockerfile for the base image to set up an environment to be used with the [Introduction to Quantitative Text Analysis for Linguistics textbook](https://qtalr.com).

Properties:

- Based on the rocker/r-ver:4.4.1 image
- Installs Python3, radian, Pandoc (3.1.11.1) and Quarto (1.5.56)
- Creates a non-root user `ruser` with passwordless `sudo` access
- Installs R packages: {pak}, {renv}, {knitr}, {rmarkdown} and {tinytext}, as well as running the TinyTex installer adding the executables to `~/.local/bin/`

## Usage

The image can be found on Docker Hub at [francojc/qtalr-r](https://hub.docker.com/r/francojc/qtalr-r). To use it, you can run:

```bash

docker run -it francojc/qtalr-r:latest

```

Or you can create a container with a volume to mount your local directory:

```bash
docker run -it -v /path/to/your/local/directory:/home/ruser francojc/qtalr-r:latest
```

Alternatively, you can use Docker Desktop to run the image and connect it to a host directory.

> [!NOTE]
> I highly recommend installing packages with {pak} instead of the default `install.packages()` function. This will ensure that when packages are installed, any system dependencies are also installed.

## Extending images

Other images that extend this image include:

- francojc/qtalr-rstudio\
  Includes RStudio.
- francojc/qtalr-vscode (coming soon)
- francojc/qtalr-neovim (coming soon)

You can of course extend this image to create your own custom image.
