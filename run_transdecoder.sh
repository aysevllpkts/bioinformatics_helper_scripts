#!/bin/bash


FASTA=$1
OUT=$2
pfam_file=$3
blast_file=$4



# To run LongOrfs with minimum ORF length as 100 amino acids.
TransDecoder.LongOrfs -t ${FASTA} --output_dir $OUT &>> $OUT/${FASTA%%.fasta}.log

# To run Predict
TransDecoder.Predict -t $IN_DIR/$FASTA --retain_pfam_hits $pfam_file --retain_blastp_hits $blast_file --single_best_only -O $OUT
