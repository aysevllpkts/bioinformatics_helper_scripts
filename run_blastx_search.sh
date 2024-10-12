#!/bin/bash


DB=$1
IN=$2
OUT=$3


diamond blastx --db $DB --query $IN \
    --outfmt 6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore stitle \
    --out $OUT --max-target-seqs 1 --threads 8 --evalue 1e-5
