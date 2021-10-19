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
cd f5c-$VERSION

# build htslib
cd htslib
chmod +x ./configure
./configure --enable-bz2=no --enable-lzma=no --with-libdeflate=no --enable-libcurl=no  --enable-gcs=no --enable-s3=no
make clean
./configure --enable-bz2=no --enable-lzma=no --with-libdeflate=no --enable-libcurl=no  --enable-gcs=no --enable-s3=no
make -j8

# build f5c
cd ..
./configure
make clean
./configure
make cuda=1 CUDA_LIB=/usr/local/cuda/lib64/ # make cuda=1 to enable CUDA support




