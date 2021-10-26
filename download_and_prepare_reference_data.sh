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
wget $refgenomafaUrl
$thisDir/nanopolish/minimap2/minimap2 -x map-ont -d hg19_nanodip.mmi hg19.fa.gz

refgenomefa="/applications/reference_data/minimap_data/hg19.fa" 
refgenomemmi="/applications/reference_data/minimap_data/hg19_20201203.mmi" # human reference genome minimap2 mmi
ilmncgmapfile="/applications/reference_data/minimap_data/hg19_HumanMethylation450_15017482_v1-2_cgmap.tsv" # Illumina probe names of the 450K array

cd $thisDir
