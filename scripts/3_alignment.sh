#!/bin/bash
set -e

BASE=~/RNAtoolkit
TRIM=$BASE/trimmed_fastq
REF=$BASE/reference_genome
ALIGN=$BASE/aligned_reads

THREADS=1

SAMPLES=(SRR35488286 SRR35488287 SRR35488288 SRR35488289)

mkdir -p $ALIGN

# Download genome if needed
if [ ! -d "$REF/grch38" ]; then
  cd $REF
  wget https://genome-idx.s3.amazonaws.com/hisat/grch38_genome.tar.gz
  tar -xvzf grch38_genome.tar.gz
fi

for srr in "${SAMPLES[@]}"; do

  echo "Aligning $srr..."

  # Subset (as you originally did)
  zcat $TRIM/${srr}_1_paired.fastq.gz | head -n 2000000 > ${srr}_1_subset.fastq
  zcat $TRIM/${srr}_2_paired.fastq.gz | head -n 2000000 > ${srr}_2_subset.fastq

  # HISAT2
  hisat2 -p $THREADS -x $REF/grch38/genome \
  -1 ${srr}_1_subset.fastq \
  -2 ${srr}_2_subset.fastq \
  -S $ALIGN/${srr}.sam

  # SAM → BAM
  samtools view -bS $ALIGN/${srr}.sam > $ALIGN/${srr}.bam

  # Sort
  samtools sort $ALIGN/${srr}.bam -o $ALIGN/${srr}_sorted.bam

  # Index
  samtools index $ALIGN/${srr}_sorted.bam

  # Cleanup
  rm $ALIGN/${srr}.sam
  rm ${srr}_1_subset.fastq ${srr}_2_subset.fastq

done

echo "Alignment completed"
