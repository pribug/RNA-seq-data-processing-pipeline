#!/bin/bash
set -e

# RNA-seq Data Acquisition + Initial QC

BASE=~/RNAtoolkit
SRA_TOOLKIT=$BASE/sratoolkit/bin

SAMPLES=(SRR35488286 SRR35488287 SRR35488288 SRR35488289)

mkdir -p $BASE/raw_fastq
mkdir -p $BASE/tmp/sra

for srr in "${SAMPLES[@]}"; do

  echo "Processing $srr..."

  # Download data
  $SRA_TOOLKIT/prefetch $srr -O $BASE/tmp/sra

  # Convert to FASTQ (paired-end)
  $SRA_TOOLKIT/fasterq-dump $BASE/tmp/sra/$srr/$srr.sra -O $BASE/raw_fastq --split-files

  # QC
  fastqc $BASE/raw_fastq/${srr}_1.fastq
  fastqc $BASE/raw_fastq/${srr}_2.fastq

  # Compress
  gzip $BASE/raw_fastq/${srr}_1.fastq
  gzip $BASE/raw_fastq/${srr}_2.fastq

  # Cleanup SRA
  rm -rf $BASE/tmp/sra/$srr

done

echo "Download + QC completed"
