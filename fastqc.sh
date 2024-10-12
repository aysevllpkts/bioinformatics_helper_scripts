#!/bin/bash

INPUT=$1
OUTPUT_DIR=$2
threads=$3

fastqc -t ${threads} ${INPUT} --outdir ${OUTPUT_DIR}
