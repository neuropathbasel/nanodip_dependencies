#!/bin/bash

# clean build directories before git commits
thisDir=`pwd`

# f5c
cd $thisDir/f5c-v0.6
cd htslib
make clean
cd ..
make clean
cd ..

# samtools
cd $thisDir/samtools/htslib
chmod +x ./configure
./configure
make clean
cd ..
./configure --with-htslib=./htslib          # Needed for choosing optional functionality
make clean

# nanopolish & minimap2
cd $thisDir/nanopolish
make clean
cd minimap2
make clean
cd ..
cd ..

# R-3-6-3
rm -rf $thisDir/tmp
rm -rf $thisDir/R-3.6.3

# reference_data
rm -rf $thisDir/reference_data

# demo data
rm -rf $thisDir/demo_data/demo_generated_result/*


