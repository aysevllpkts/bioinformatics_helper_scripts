#!/bin/bash


MMI=$1 # minimap2 genome index
IN=$2 # fasta file
OUT=$3 #bam file

pbmm2 align $MMI $IN $OUT --preset HiFi --unmapped --sort -j 8 -J 2 --log-level INFO 

