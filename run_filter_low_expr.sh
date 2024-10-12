#!/bin/bash

TRANSCRIPTOME=$1
GENE_TRANS_MAP=$2
RSEM_INPUT=$3
OUT_DIR=$4
OUTPUT_PREFIX=$5


#### create expression matrix
abundance_estimates_to_matrix.pl --est_method RSEM --gene_trans_map $GENE_TRANS_MAP $OUT_DIR/$RSEM_INPUT --out_prefix $OUTPUT_PREFIX

####
$TRINITY_HOME/util/misc/count_matrix_features_given_MIN_TPM_threshold.pl $OUTPUT_PREFIX.isoform.TPM.not_cross_norm | tee $OUTPUT_PREFIX.isoform.TPM.not_cross_norm.counts_by_min_TPM

#### filter low expressed contigs
filter_low_expr_transcripts.pl \
--matrix $OUT_DIR/$OUTPUT_PREFIX.isoform.TPM.not_cross_norm \
--transcripts $TRANSCRIPTOME --gene_to_trans_map $GENE_TRANS_MAP \
--min_expr_any 1 > $OUT_DIR/RSEM_filtered/RSEM_sample_min1.fa

filter_low_expr_transcripts.pl \
--matrix $OUT_DIR/$OUTPUT_PREFIX.isoform.TPM.not_cross_norm \
--transcripts $TRANSCRIPTOME --gene_to_trans_map $GENE_TRANS_MAP \
--min_expr_any 0.1 > $OUT_DIR/RSEM_filtered/RSEM_sample_min0.1.fa

filter_low_expr_transcripts.pl \
--matrix $OUT_DIR/$OUTPUT_PREFIX.isoform.TPM.not_cross_norm \
--transcripts $TRANSCRIPTOME --gene_to_trans_map $GENE_TRANS_MAP \
--min_expr_any 0.01 > $OUT_DIR/RSEM_filtered/RSEM_sample_min0.01.fa

filter_low_expr_transcripts.pl \
--matrix $OUT_DIR/$OUTPUT_PREFIX.isoform.TPM.not_cross_norm \
--transcripts $TRANSCRIPTOME --gene_to_trans_map $GENE_TRANS_MAP \
--min_expr_any 0.0001 > $OUT_DIR/RSEM_filtered/RSEM_sample_min0.0001.fa