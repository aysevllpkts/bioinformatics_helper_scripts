#!/bin/bash

IN=$1
ASSEMBLY=$2
OUT=$3

bowtie2-build --threads 4 $IN/$ASSEMBLY $OUT/${ASSEMBLY}


