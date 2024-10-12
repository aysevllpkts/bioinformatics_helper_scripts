#!/bin/bash


IN=$1
OUT=$2

samtools view -Sb $IN -@ 4 -m 1G  | samtools sort -@ 4 -m 1G -o $OUT
