#!/bin/bash


TRANSCRIPTOME=$1
LEFT=$2
RIGHT=$3
OUT_DIR=$4
GENE_TRANS_MAP=$5


# align and abundance 
align_and_estimate_abundance.pl --transcripts $TRANSCRIPTOME --seqType fq --left $LEFT --right $RIGHT \
    --est_method RSEM --aln_method bowtie2 --gene_trans_map $GENE_TRANS_MAP --thread_count 8 --output_dir $OUT_DIR


