#!/bin/bash


############################## ABOUT #######################################
# clustering combined data based on similarity among transcripts           #
# OUTPUT WILL BE clustered transcripts                                     #
############################################################################



IN=$1
OUT=$2
cd-hit-est -i $IN -o $OUT -c 0.95 -T 8 -M 4000 -G 0 -aL 0.00 -aS 0.99 -AS 30

# for protein 
#cd-hit -i $IN -o $OUT -c 0.98 -T 8 -M 0 -G 0 -aL 0.005 -aS 0.99


