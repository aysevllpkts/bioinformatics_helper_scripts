#!/bin/bash


FILE=$1
threads=4
memory=4000
value=$2

$evigene/scripts/prot/tr2aacds4_22a.pl -cdnaseq $FILE -NCPU=$threads -MAXMEM=$memory -MINAA=100 -logfile -ablastab=blastp_table  -pHeterozygosity=$value
