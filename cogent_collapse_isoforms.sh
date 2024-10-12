#!/bin/bash


GENOME=$1
IN_SAM=$2
IN_READS=$3
OUT_DIR=$4
NAME=$5


minimap2 -ax splice -t 8 -uf --secondary=no $GENOME $IN_READS > $IN_SAM/${NAME}.sam

sort -k 3,3 -k 4,4n $IN_SAM/${NAME}.sam > $IN_SAM/${NAME}_sorted.sam

collapse_isoforms_by_sam.py --input $IN_READS -s $IN_SAM/${NAME}_sorted.sam -c 0.99 -i 0.95 --max_5_diff 10000 --max_3_diff 1000 -o ${NAME}_9599.5merge

python /home/aysevil/Tools/Cogent/Cogent/helper_scripts/get_bad_or_unmapped_hq.py $IN_READS ${NAME}_9599.5merge
