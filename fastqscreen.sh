#!/bin/bash

IN_DIR=$1
FILE=$2
OUT_DIR=$3
config=$4


fastq_screen --conf $config --aligner bowtie2 --nohits ${IN_DIR}/${SAMPLE} \
    --threads 8 --outdir $OUT_DIR 2> $OUT_DIR/${SAMPLE%%.fastq}.log


