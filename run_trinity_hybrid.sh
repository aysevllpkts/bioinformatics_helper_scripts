#!/bin/bash


SHORT_READS_DIR=$1	
LONG_READS_FASTA=$2



# RUN TRINITY HYBRID
Trinity --seqType fq --max_memory 80G --CPU 16  \
    --left ${SHORT_READS_DIR}/merged_1.trimmed.fq.gz --right ${SHORT_READS_DIR}/merged_2.trimmed.fq.gz --long_reads $LONG_READS_FASTA \
    --min_kmer_cov 3 --min_glue 4 --min_contig_length 200 --output 
 
##############################
