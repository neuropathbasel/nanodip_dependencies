#!/bin/bash

# nanopolish & minimap2
cd nanopolish
make clean
cd minimap2
make clean
cd ..
make
cd minimap2
make

