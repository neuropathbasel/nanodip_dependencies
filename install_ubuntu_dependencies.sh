#!/bin/bash

# installation of ubuntu system dependencies of nanodip dependecies for Ubuntu 18.04 x86_64 with NVIDIA CUDA GPU
# 1) f5c
# 2) samtools: libcurl4-openssl-dev libssl-dev already in set for R
# 3) R 3.6.3: it makes sense to install r-base even though we'll use the specific R 3.6.3 simply to avoid missing dependecies
sudo apt-get -y install \
gzip \
cuda libhdf5-dev zlib1g-dev \
libncurses5-dev libbz2-dev liblzma-dev  autoconf \
r-base build-essential fort77 xorg-dev liblzma-dev libblas-dev \
gfortran gobjc++ aptitude libreadline-dev libbz2-dev libpcre2-dev libcurl4 libcurl4-openssl-dev \
default-jre default-jdk openjdk-8-jdk openjdk-8-jre  texinfo texlive texlive-fonts-extra -y \
libssl-dev -y libxml2-dev libjpeg-dev

