# qtalr-r base image

This repo contains the Dockerfile for the base image to set up an environment to be used with the [Introduction to Quantitative Text Analysis for Linguistics textbook](https://qtalr.com).

Properties:

- Based on the rocker/r-ver:4.4.1 image
- Installs Pandoc (3.1.11.1) and Quarto (1.5.56)
- Creates a non-root user `ruser` with passwordless `sudo` access
- Installs R packages: {pak}, {renv}, {knitr}, {rmarkdown} and {tinytext}, as well as running the TinyTex installer adding the executables to `~/.local/bin/`

## Usage

The image can be found on Docker Hub at [qtalr/qtalr-r](https://hub.docker.com/r/qtalr/qtalr-r). To use it, you can run:

```bash

docker run -it qtalr/qtalr-r:latest

```

Or you can create a container with a volume to mount your local directory:

```bash
docker run -it -v /path/to/your/local/directory:/home/ruser qtalr/qtalr-r:latest
```

Alternatively, you can use Docker Desktop to run the image and connect it to a host directory.

## Extending images

Other images that extend this image include:

- qtalr-rstudio\
  Installs RStudio Server. You will need to specify the `PASSWORD` environment variable and the port to map to the host machine which defaults to 8787. To run this from the command line:

```bash
docker run -d -p 8787:8787 -e PASSWORD=yourpassword qtalr/qtalr-rstudio:latest
```

Or use Docker Desktop and include these variables and values using the GUI interface.

- qtalr-vscode (coming soon)
- qtalr-neovim (coming soon)

You can of course extend this image to create your own custom image.
