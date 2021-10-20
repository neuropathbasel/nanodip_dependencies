#!/bin/bash

# install samtools on ubuntu 18.04 x86_64
sudo apt -y install libncurses5-dev libbz2-dev liblzma-dev libcurl4-openssl-dev libssl-dev autoconf

# compile htslib
cd samtools/htslib
autoconf -i
chmod +x ./configure
./configure
make clean
./configure
make

# compile samtools
cd ..
autoheader            # Build config.h.in (this may generate a warning about # AC_CONFIG_SUBDIRS - please ignore it).
autoconf -Wno-syntax  # Generate the configure script
./configure --with-htslib=./htslib          # Needed for choosing optional functionality
make clean
./configure --with-htslib=./htslib          # Needed for choosing optional functionality
make
