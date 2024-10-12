#!/bin/bash

 
DB=$1
IN=$2

# this is much slower
#hmmscan --cpu 8 --domtblout ${IN%%.fasta}.out $DB $IN

hmmsearch --cpu 8 --noali --domtblout ${IN%%.fasta}.out $DB $IN
