#!/bin/bash

# local R installation / from cran; not hosted in this git repo; too large
myR="R-3.6.3"
myRbranch="R-3"

thisDir=`pwd`
cd ..

mkdir -p tmp

rm -rf tmp/$myR.tar.gz
rm -rf $myR
cd tmp
wget `echo "https://cran.r-project.org/src/base/"$myRbranch"/"$myR".tar.gz"`
cd ..
tar -xzvf `echo tmp/$myR".tar.gz"` -C ./

cd $myR
./configure
make

cd $thisDir
