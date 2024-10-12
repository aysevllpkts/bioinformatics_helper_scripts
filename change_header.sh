#!/bin/bash

#################### ABOUT #######################
# I CHANGE THE HEADER DUE TO ERROR IN BUSCO      #
# ORIGINAL TRANSCRIPT STARTS WITH "transcript/1" #
# BUSCO DOES NOT ACCEPT "/"                      #
# SO, I CHANGED ALL "/" WITH "_"                 #
##################################################

############################################ FMLRC ####################################################

IN_FILE=$1
OUT_FILE=$2


awk '{gsub("\\/", "_", $0); quit};1' $IN_FILE > $OUT_FILE

