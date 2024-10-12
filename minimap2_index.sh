#!/bin/bash


ASSEMBLY=$1
PREFIX=$2

# Build index
minimap2 -I 24g -d $PREFIX $ASSEMBLY -t 8
