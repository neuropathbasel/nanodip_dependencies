#!/bin/bash

# download and prepare reference data
thisDir=`pwd`
cd ..
appDir=`pwd`
targetDir=$appDir/reference_data
mkdir -p $targetDir/minimap_data
# human reference genome
refgenomafaUrl="http://hgdownload.cse.ucsc.edu/goldenPath/hg19/bigZips/hg19.fa.gz"

cd $targetDir/minimap_data
wget $refgenomafaUrl -O hg19.fa.gz
gunzip hg19.fa.gz

$appDir/nanopolish/minimap2/minimap2 -x map-ont -d hg19_nanodip.mmi hg19.fa

mkdir -p $appDir/reference_data/microarray
cp $thisDir/demo_data/microarray/hg19_HumanMethylation450_15017482_v1-2_cgmap.tsv $appDir/reference_data/microarray/

cd $thisDir
