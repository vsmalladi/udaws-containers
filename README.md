U-DAWS Containers
==========

This repository houses `Dockerfile`s and tests for producing versioned container images for
University of Texas Southwestern Data Analysis Workflows for Sequencing.

Images produced are are pushed to [Docker Store](https://store.docker.com/) under the [medforomics organization](https://store.docker.com/u/medforomics/) and suitable for use in [Nextflow](https://www.nextflow.io/) workflows or under [Singularity](http://singularity.lbl.gov) using [U-DAWS Workflows](https://git.biohpc.swmed.edu/BICF/Astrocyte/process_scripts).

The directory structure of this repository uses a convention to determine the names and tags of built docker images, which is explained below.

## Directory Structure

As this repository houses many `Dockerfile`s, the directory structure allows those to be organized by process name and version, allowing automatic builds and versioning conventions.

`Dockerfile`s are organized into subdirectories based on the process and version. For example, the Dockerfile for trimreads version 0.1.0 is located at `trimreads/0.1.0/Dockerfile`.

### Versioning and Tags

To preserve versions we adopt the below convention when building:

* The name of the directory immediately containing the `Dockerfile` is used as the Docker image tag when building

```
$ ls -ld fastqc/*
drwxr-xr-x  4 venkatmalladi  staff  136 May 30 13:54 trimreads/0.1.0
```

Will build a Docker image `medforomics/trimreads:0.1.0` from the `Dockerfile` in `trimread/0.1.0`, and also tag that image as `medforomics/trimreads:latest`.

### Naming Restrictions

When naming directories, it's important to use names that are also valid for Docker images and tags. Sometimes, tool names and versions may contain characters (e.g. `+`) that are not valid for Docker image names or tags.

From [docs.docker.com](https://docs.docker.com/engine/reference/commandline/tag/#extended-description), regarding image names:

> Name components may contain **lowercase** letters, digits and separators. A separator is defined as a period, one or two underscores, or one or more dashes. A name component may not start or end with a separator.

Tags:

> A tag name must be valid ASCII and may contain lowercase and uppercase letters, digits, underscores, periods and dashes. A tag name may not start with a period or a dash and may contain a maximum of 128 characters.

## Continuous Integration

[![Build Status](https://travis-ci.org/medforomics/udaws-containers.svg?branch=master)](https://travis-ci.org/medforomics/udaws-containers)

This repository includes scripts to automate the building, testing, and pushing of Docker images to the public Docker registry.

The [`ci`](ci) contains files necessary for deployment via continuous integration. For the CI configuration, see [`.travis.yml`](.travis.yml).

The scripts that run these processes are are in [build.sh](build.sh), [test.sh](test.sh), and [deploy.sh](deploy.sh). Each depends on the conventions denoted above, and use functions from [functions.sh](functions.sh) to determine what to process at each stage.

These processes happen on [TravisCI](https://travis-ci.org/medforomics/udaws-containers), and expect the following 4 environment variables:

- `DEPLOY_BRANCH` - When changes are made on this git branch (typically `master`), built images will be pushed to Docker Hub
- `DOCKERHUB_ORG` - The Docker organization name to use when naming and pushing built images (e.g. `medforomics`)
- `DOCKERHUB_USERNAME` - The Docker Hub username to use when authenticating with Docker Hub. See below.
- `DOCKERHUB_PASSWORD` - The Docker Hub password to use when authenticating with Docker Hub. See below.

### Docker Hub Credentials

For the CI service to push to Docker Hub, it must login with `docker login`. It uses the username/password set in the above variables.


### Testing

Beside each `Dockerfile` there should be a `unittest.yml` file describing how to test the built image.  These tests are intended to confirm that the expected tool version has been installed in the image and executes when run.

The [unittest.yml](trimreads/0.1.1/unittest.yml) has a test for FastQC that simply asserts that running the `fastqc -h` command produces usage text:

```
commands:
  - cmd: "fastqc -h"
    expect_text: ".*fastqc seqfile1 seqfile2.*"
```

### Build

Dockerfiles are built with the command noted in [functions.sh](functions.sh):

```
docker build -f $tool/$version/Dockerfile" -t "$owner/$tool:$version" "$tool/$version"
```

So this build command can easily be run locally to confirm the image builds correctly.
