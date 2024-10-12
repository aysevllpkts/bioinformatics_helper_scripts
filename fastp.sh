#!/bin/bash

SAMPLE=$1
R1=$2
R2=$3
ADAPTER=$4


fastp -i $R1 -I $R2 -o ${SAMPLE}_1.trimmed.fq.gz -O ${SAMPLE}_2.trimmed.fq.gz \
    -w 8 --adapter_fasta $ADAPTER --json ${SAMPLE}.json --html ${SAMPLE}.html  \
    -r --cut_window_size 4 --cut_mean_quality 15 --correction -l 50

