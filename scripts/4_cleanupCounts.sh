#!/bin/bash
set -e

BASE=~/RNAtoolkit
COUNTS=$BASE/aligned_reads/gene_counts.txt

echo "Cleaning featureCounts output..."

# Remove comment line + keep Geneid + counts
tail -n +2 $COUNTS | cut -f1,7- > clean_counts.txt

# Fix header (important for DESeq2)
sed -i '1s/.*/Geneid\tSRR35488286\tSRR35488287\tSRR35488288\tSRR35488289/' clean_counts.txt

echo "Clean counts file generated: clean_counts.txt"
