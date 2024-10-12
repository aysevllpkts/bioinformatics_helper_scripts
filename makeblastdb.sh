#!/bin/bash


DB=$1
type=$2
title=$3


makeblastdb -in $DB -dbtype $type -title $title -logfile log



