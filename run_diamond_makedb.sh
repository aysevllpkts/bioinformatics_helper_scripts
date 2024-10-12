#!/bin/bash


DB=$1

#FASTA=/faststorage/project/MolGen/aysevil/DBs/uniref90/uniref90.fasta
#INDEX=/faststorage/project/MolGen/aysevil/DBs/diamond/uniref90

#diamond makedb --in Pappa2_refseq_protein.fasta -d Pappa2_refseq_protein
diamond makedb --in $DBs -d ${DB%%.fasta}.dmnd