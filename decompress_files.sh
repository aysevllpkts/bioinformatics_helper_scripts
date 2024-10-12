#!/bin/bash

FILE=$1

gunzip -c $FILE > ${FILE%%.gz}
