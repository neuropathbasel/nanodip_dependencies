#!/bin/bash

# install f5c from github on ubuntu 18.04 x86_64
# Hultschig C and Hench J 2021 IfP Basel

# install cuda additional packages, cuda version at present is 11.4, adapt version according to CUDA information
# obtained via nvidia-smi
sudo apt -y install cuda
sudo apt -y install libhdf5-dev zlib1g-dev   #install HDF5 and zlib development libraries

# use the currently "set" CUDA, 11.4 at present (20210908)
export PATH="/usr/local/cuda/bin:${PATH}"

VERSION=v0.6
cd /applications
wget "https://github.com/hasindu2008/f5c/releases/download/$VERSION/f5c-$VERSION-release.tar.gz"
tar xvf f5c-$VERSION-release.tar.gz
cd f5c-$VERSION
#scripts/install-hts.sh  # download and compile the htslib
#./configure
make cuda=1 CUDA_LIB=/usr/local/cuda/lib64/ # make cuda=1 to enable CUDA support
