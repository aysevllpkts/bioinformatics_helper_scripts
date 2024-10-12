#!/bin/bash



IN_DIR=$1
FILE=$2

insilico_read_normalization.pl --seqType fq --left $IN_DIR/${FILE}_P1.fq --right $IN_DIR/${FILE}_P2.fq --single $IN_DIR/${FILE}_singletons.fq --CPU 10 --JM 100G --max_cov 30 --min_cov 3
