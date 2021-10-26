#!/bin/bash

thisDir=`pwd`
cp -rpvf nanopolish ../
cd ../nanopolish

# nanopolish & minimap2
make clean
cd minimap2
make clean
cd ..
make
cd minimap2
make

cd $thisDir
