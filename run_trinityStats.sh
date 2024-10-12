#!/bin/bash


IN=$1


TrinityStats.pl $IN > ${IN%%.fasta}_trinityStats.txt
