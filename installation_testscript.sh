#!/bin/bash

thisDir=`pwd`
cd ..
appDir=`pwd`

fast5datadir=$thisDir/demo_data/GBM_RTK2_20210311_Testrun_BC06/GBM_RTK2_20210311_Testrun_BC06/20210311_1151_MN26891_FAP12445_0513da25/fast5_pass/barcode06/
fast5fileid=FAP12445_pass_barcode06_cc9c5597_0
fastqfile=$thisDir/demo_data/GBM_RTK2_20210311_Testrun_BC06/GBM_RTK2_20210311_Testrun_BC06/20210311_1151_MN26891_FAP12445_0513da25/fastq_pass/barcode06/FAP12445_pass_barcode06_cc9c5597_0.fastq
refgenomefa=$appDir/reference_data/minimap_data/hg19.fa
refgenomemmi=$appDir/reference_data/minimap_data/hg19_nanodip.mmi
ilmncgmapfile=$appDir/reference_data/microarray/HumanMethylation450_15017482_v1-2_cgmap.tsv # Illumina probe names of the 450K array

#index, call methylation and get methylation frequencies
$appDir/f5c/f5c index -t 1 --iop 100 -d $fast5datadir $fastqfile
# get sorted BAM (4 threads)
$appDir/nanopolish/minimap2/minimap2 -a -x map-ont $refgenomemmi $fastqfile -t 4 | ./samtools/samtools sort -T tmp -o $fast5datadir/$fast5fileid-reads_sorted.bam
$appDir/samtools/samtools index $fast5datadir/$fast5fileid-reads_sorted.bam

# set B to 2 megabases (GPU) and 0.4 kreads
$appDir/f5c/f5c call-methylation -B2000000 -K400 -b $fast5datadir/$fast5fileid-reads_sorted.bam -g $refgenomefa -r $fastqfile  > $fast5datadir/$fast5fileid-result.tsv
$appDir/f5c/f5c meth-freq -c 2.5 -s -i $fast5datadir/$fast5fileid-result.tsv > $fast5datadir/$fast5fileid-freq.tsv

# extract overlap CpGs according to Illumina 450K table
$appDir/R-4.0.3/bin/Rscript ./nanodip_dependencies/rscripts/readCpGs_mod02.R $fast5datadir/$fast5fileid-freq.tsv $ilmncgmapfile $fast5datadir/$fast5fileid-methoverlap.tsv $fast5datadir/$fast5fileid-methoverlapcount.txt

