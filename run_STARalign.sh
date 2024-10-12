#!/bin/bash


R1=$1
R2=$2
GENOME=$3
PREFIX=$4

STAR --genomeDir  $GENOME  \
--runThreadN 6 \
--readFilesIn $R1 $R2 \
--outFileNamePrefix $PREFIX \
--outSAMtype BAM SortedByCoordinate \
--outSAMunmapped Within \
--outSAMattributes Standard 