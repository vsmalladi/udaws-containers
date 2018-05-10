U-DAWS Containers
==========

This repository houses `Dockerfile`s and tests for producing versioned container images for
University of Texas Southwestern Data Analysis Workflows for Sequencing.

Images produced are are pushed to [Docker Hub](https://hub.docker.com/) under the [meforomics organization](https://hub.docker.com/u/medforomics/) and suitable for use in [Nextflow](https://www.nextflow.io/) workflows or under [Singularity](http://singularity.lbl.gov) using [U-DAWS Workflows](https://git.biohpc.swmed.edu/BICF/Astrocyte/process_scripts).

The directory structure of this repository uses a convention to determine the names and tags of built docker images, which is explained below.

## Directory Structure

As this repository houses many `Dockerfile`s, the directory structure allows those to be organized by process name and version, allowing automatic builds and versioning conventions.

`Dockerfile`s are organized into subdirectories based on the process and version. For example, the Dockerfile for bamqc version 0.1.0 is located at `bamqc/0.1.0/Dockerfile`.
