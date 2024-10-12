#!/bin/bash


IN=$1
OUT=$2
DIR_NAME=$3	
LINEAGE=$4
DATA_PATH=$5

busco -c 8 -m trans --in $IN -o $DIR_NAME -l $LINEAGE --out_path $OUT --download_path $DATA_PATH

