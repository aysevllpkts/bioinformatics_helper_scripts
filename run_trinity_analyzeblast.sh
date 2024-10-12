#!/bin/bash

REF=$1
ASSEMBLY=$2
OUTFMT=$3



$TRINITY_HOME/util/analyze_blastPlus_topHit_coverage.pl $OUTFMT $ASSEMBLY $REF

$TRINITY_HOME/util/misc/blast_outfmt6_group_segments.pl $OUTFMT $ASSEMBLY $REF > $OUTFMT.grouped
$TRINITY_HOME/util/misc/blast_outfmt6_group_segments.tophit_coverage.pl  $OUTFMT.grouped >  $OUTFMT.grouped.hist

