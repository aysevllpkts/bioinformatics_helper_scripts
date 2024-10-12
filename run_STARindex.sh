#!/bin/bash


DIR=$1
FASTA=$2
GFT=$3

STAR --runThreadN 8 \
--runMode genomeGenerate \
--genomeDir $DIR \
--genomeFastaFiles $FASTA \
--sjdbGTFfile  $GTF \
--sjdbOverhang 99 \
--genomeSAindexNbases 13