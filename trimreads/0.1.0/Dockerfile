# Base Image

FROM ubuntu:18.04

# Metadata

LABEL maintainer="Venkat Malladi"
LABEL authors='venkat.malladi@utsouthwestern.edu'
LABEL version='0.1.0'
LABEL software='trimgalore, cutadapt, fastqc'
LABEL description='Image containing software to run read fastq triming.'
LABEL tags='NGS'

# Install prerequisites

RUN apt-get -y update --fix-missing && \
    apt-get install -y wget gzip curl git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install miniconda to /miniconda

RUN curl -LO http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh
RUN bash Miniconda-latest-Linux-x86_64.sh -p /miniconda -b
RUN rm Miniconda-latest-Linux-x86_64.sh
ENV PATH=/miniconda/bin:${PATH}
RUN conda update -y conda

# Install FastQC and dependencies
# Install FastQC and dependencies

# Needed for FastQC - conda build hangs without this
ENV OPENJDK_VERSION=8.0.144
RUN \
  conda install -c conda-forge openjdk=${OPENJDK_VERSION}

ENV FASTQC_VERSION=0.11.5
RUN \
  conda install -c bioconda fastqc=${FASTQC_VERSION}

# Install cutadapt

ENV CUTADAPT_VERSION=1.9.1
RUN \
  conda install -c bioconda cutadapt=${CUTADAPT_VERSION}

# Install TrimGalore

ENV TRIMGALORE_VERSION="0.4.1"
RUN \
  conda install -c bioconda trim-galore=${TRIMGALORE_VERSION}

# Make working directory
WORKDIR /data/

# Export Path

ENV PATH=$PATH:/opt/conda/bin/python
