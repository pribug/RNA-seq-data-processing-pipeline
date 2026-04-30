#!/bin/bash
set -e

BASE=~/RNAtoolkit
TRIMMO="/usr/share/java/trimmomatic.jar"
ADAPTER="/usr/share/trimmomatic/TruSeq3-PE.fa"

SAMPLES=(SRR35488286 SRR35488287 SRR35488288 SRR35488289)

mkdir -p $BASE/trimmed_fastq

for srr in "${SAMPLES[@]}"; do

  echo "Trimming $srr..."

  java -jar $TRIMMO PE \
  $BASE/raw_fastq/${srr}_1.fastq.gz \
  $BASE/raw_fastq/${srr}_2.fastq.gz \
  $BASE/trimmed_fastq/${srr}_1_paired.fastq.gz \
  $BASE/trimmed_fastq/${srr}_1_unpaired.fastq.gz \
  $BASE/trimmed_fastq/${srr}_2_paired.fastq.gz \
  $BASE/trimmed_fastq/${srr}_2_unpaired.fastq.gz \
  ILLUMINACLIP:$ADAPTER:2:30:10 \
  LEADING:3 TRAILING:3 \
  SLIDINGWINDOW:4:15 \
  MINLEN:36

  # QC after trimming
  fastqc $BASE/trimmed_fastq/${srr}_1_paired.fastq.gz
  fastqc $BASE/trimmed_fastq/${srr}_2_paired.fastq.gz

done

echo "Trimming completed"
