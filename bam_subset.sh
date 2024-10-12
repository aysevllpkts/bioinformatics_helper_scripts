#!/bin/bash


########### subsetting BAM file
# Create subset for all samples
##############################



IN=$1
OUT=$2
SAMPLES=$3

for i in $SAMPLES
sdo 
    cd ${OUT}/${i}
    for f in *.sam
    do
        samtools view -bS ${f} -o ${f%%.sam}.bam
    done
done