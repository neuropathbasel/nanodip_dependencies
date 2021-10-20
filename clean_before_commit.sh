#!/bin/bash

# clean build directories before git commits

# f5c
cd f5c-v0.6
cd htslib
make clean
cd ..
make clean
cd ..

# samtools
cd samtools/htslib
chmod +x ./configure
./configure
make clean
cd ..
./configure --with-htslib=./htslib          # Needed for choosing optional functionality
make clean

# nanopolish & minimap2
cd nanopolish
make clean
cd minimap2
make clean

# demo data
rm -rf demo_data/demo_generated_result/*


