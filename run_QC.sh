#!/bin/bash


# summary statistics for long reads

IN=$1
OUT=$2
NAME=$3

NanoPlot -o $OUT -p $NAME -t 4 --N50 --fasta $IN


#############################################################

