#!/bin/bash

# local R installation / from cran; not hosted in this git repo; too large
myR="R-3.6.3"
myRbranch="R-3"

# it makes sense to install r-base even though we'll use the specific R 3.6.3 simply to avoid missing dependecies
sudo apt-get -y install r-base build-essential fort77 xorg-dev liblzma-dev libblas-dev \
gfortran gobjc++ aptitude libreadline-dev libbz2-dev libpcre2-dev libcurl4 libcurl4-openssl-dev \
default-jre default-jdk openjdk-8-jdk openjdk-8-jre  texinfo texlive texlive-fonts-extra -y \
libssl-dev -y libxml2-dev libjpeg-dev

thisDir=`pwd`
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
