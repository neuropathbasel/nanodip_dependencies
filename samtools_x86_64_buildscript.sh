#!/bin/bash

thisDir=`pwd`

cp -rpvf ./samtools ../
cd ..
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

cd $thisDir
