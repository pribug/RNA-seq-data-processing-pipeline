#!/bin/bash
set -e

BASE=~/RNAtoolkit
GTF=$BASE/reference_genome/Homo_sapiens.GRCh38.110.gtf
ALIGN=$BASE/aligned_reads

echo "Running featureCounts..."

featureCounts \
-a $GTF \
-o $ALIGN/gene_counts.txt \
-T 1 \
-p --countReadPairs \
-t exon \
-g gene_id \
$ALIGN/*_sorted.bam

echo "featureCounts completed"
