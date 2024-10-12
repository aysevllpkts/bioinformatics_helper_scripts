#!/bin/bash

CPU=12
DIR=/path/to/dir
SQLITE=/path/to/myTrinotate.sqlite	
GENE_TRANS_MAP=/path/to/transcriptome_gene_trans_map.txt
TRANSCRIPT=/ath/to/transcriptome.fasta
PEP=/path/to/protein.fasta
TRINOTATE_DATA_DIR=/path/to/TRINOTATE_DATA_DIR

# Initial
$TRINOTATE_HOME/Trinotate --db $SQLITE --create --trinotate_data_dir $TRINOTATE_DATA_DIR

# Initial import of transcriptome and protein data: # modify header names of the pep file as transdecoder output
$TRINOTATE_HOME/Trinotate --db $SQLITE --init --gene_trans_map $GENE_TRANS_MAP --transcript_fasta $TRANSCRIPT --transdecoder_pep $PEP

# Running annotation computes automatically including auto-loading of result

# all
#$TRINOTATE_HOME/Trinotate --db $SQLITE --run ALL --CPU $CPU --transcript_fasta $TRANSCRIPT --transdecoder_pep $PEP --use_diamond

# specific
$TRINOTATE_HOME/Trinotate --db $SQLITE --CPU 8 --transcript_fasta $TRANSCRIPT --transdecoder_pep $PEP --run "swissprot_blastp swissprot_blastx" --use_diamond 
$TRINOTATE_HOME/Trinotate --db $SQLITE --CPU 12 --transcript_fasta $TRANSCRIPT --transdecoder_pep $PEP --run "signalp6" --use_diamond 
$TRINOTATE_HOME/Trinotate --db $SQLITE --CPU 8 --transcript_fasta $TRANSCRIPT --transdecoder_pep $PEP --run "infernal" --use_diamond 
$TRINOTATE_HOME/Trinotate --db $SQLITE --CPU 8 --transcript_fasta $TRANSCRIPT --transdecoder_pep $PEP --run "EggnogMapper" --use_diamond
$TRINOTATE_HOME/Trinotate --db $SQLITE --CPU 8 --transcript_fasta $TRANSCRIPT --transdecoder_pep $PEP --run "pfam" --use_diamond
$TRINOTATE_HOME/Trinotate --db $SQLITE --CPU 8 --transcript_fasta $TRANSCRIPT --transdecoder_pep $PEP --run "tmhmmv2" --use_diamond

# LOAD custom dbs - example
#$TRINOTATE_HOME/Trinotate --db $SQLITE --LOAD_custom_blast </path/to/custom_db.outfmt6> --blast_type <blastx/blastp> --custom_db_name <DB_name> 

# Get report
$TRINOTATE_HOME/Trinotate --db $SQLITE --report > my_trinotate.xls

# hits summary table
$TRINOTATE_HOME/util/count_table_fields.pl my_trinotate.xls > annotation_table_fields.txt

# extract go terms - include ancestral terms (-I), gene (-G)
$TRINOTATE_HOME/util/extract_GO_assignments_from_Trinotate_xls.pl --Trinotate_xls my_trinotate.xls -T > myTrinotate.goterms

# get go_slims terms
$TRINOTATE_HOME/util/gene_ontology/Trinotate_GO_to_SLIM.pl myTrinotate.goterms > myTrinotate.goslims
