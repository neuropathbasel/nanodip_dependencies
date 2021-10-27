#!/bin/bash

thisDir=`pwd`
cd ..

VERSION=v0.6

fast5datadir=$thisDir/demo_data/GBM_RTK2_20210311_Testrun_BC06/GBM_RTK2_20210311_Testrun_BC06/20210311_1151_MN26891_FAP12445_0513da25/fast5_pass/barcode06/
fast5fileid=FAP12445_pass_barcode06_cc9c5597_0
fastqfile=$thisDir/demo_data/GBM_RTK2_20210311_Testrun_BC06/GBM_RTK2_20210311_Testrun_BC06/20210311_1151_MN26891_FAP12445_0513da25/fastq_pass/barcode06/FAP12445_pass_barcode06_cc9c5597_0.fastq
refgenomemmi=./reference_dat/reference_data/minimap_data/hg19_nanodip.mmi

#index, call methylation and get methylation frequencies
./f5c-$VERSION/f5c index -t 1 --iop 100 -d $fast5datadir $fastqfile
# get sorted BAM (4 threads)
./nanopolish/minimap2/minimap2 -a -x map-ont $refgenomemmi $fastqfile -t 4 | samtools sort -T tmp -o $fast5datadir/$fast5fileid-reads_sorted.bam
./samtools/samtools index $fast5datadir/$fast5fileid-reads_sorted.bam

# set B to 2 megabases (GPU) and 0.4 kreads
./f5c-$VERSION/f5c call-methylation -B2000000 -K400 -b $fast5datadir/$fast5fileid-reads_sorted.bam -g $refgenomefa -r $fastqfile  > $fast5datadir/$fast5fileid-result.tsv
./f5c-$VERSION/f5c meth-freq -c 2.5 -s -i $fast5datadir/$fast5fileid-result.tsv > $fast5datadir/$fast5fileid-freq.tsv

