#!/bin/bash



DB=$1
QUERY=$2
OUT=$3



blastn -query $QUERY -db $DB \
    -outfmt "6 qseqid staxids bitscore sseqid pident length std qcovs qcovhsp sscinames scomnames evalue stitle" \
    -max_hsps 1 -evalue 1e-25 -out $OUT -num_threads 8

