#!/bin/bash


GENOME=$1
ASSEMBLY=$2

minimap2 -t 8 -ax splice -uf --secondary=no -C5 -O6,24 -B4 $GENOME $ASSEMBLY > ${ASSEMBLY%%.fasta}.sam
samtools view -Sb ${ASSEMBLY%%.fasta}.sam -@ 4 -m 2G  | samtools sort -@ 4 -m 2G -o  ${ASSEMBLY%%.fasta}.sorted.bam

minimap2 -t 8 -ax splice:hq -uf $GENOME $ASSEMBLY > ${ASSEMBLY%%.fasta}.hq.sam
samtools view -Sb ${ASSEMBLY%%.fasta}.hq.sam -@ 4 -m 2G  | samtools sort -@ 4 -m 2G -o  ${ASSEMBLY%%.fasta}.hq.sorted.bam

