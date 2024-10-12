#!/bin/bash


IN=$1
OUT=$2

transrate --assembly $IN --threads 4 --output $OUT


