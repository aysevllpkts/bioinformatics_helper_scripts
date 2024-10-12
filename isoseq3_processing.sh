#!/bin/bash


# samples = 

# DIRECTORIES
SAMPLE=$1
RAWDATA=/0.RawData
CCS=/1.CCS
FL=/2.FL
FLNC=/3.FLNC
PRIMERS=$2

mkdir $RAWDATA $CCS $FL $FLNC

# subreads to ccs

echo working on SUBREADS TO CCS for $SAMPLE... 
mkdir $CCS/$SAMPLE
cd $RAWDATA/$SAMPLE
echo you are in $RAWDATA/$SAMPLE

for f in *.bam
do
ccs $f $CCS/$SAMPLE/${f%%.subreads.bam}.ccs.bam --min-passes 3 --min-rq 0.99 -j 12
done

# ccs to fl 

echo working on CCS TO FL for $SAMPLE...
mkdir ${FL}/${SAMPLE}
cd ${CCS}/${SAMPLE}
echo you are in ${CCS}/${SAMPLE}

for f in *.ccs.bam
do
lima ${f} ${PRIMERS} ${FL}/${SAMPLE}/${f%%.ccs.bam}.fl.bam --isoseq --peek-guess --num-threads 12 --dump-clips --dump-removed --log-level INFO --log-file ${f%%.ccs.bam}.log
done


# fl to flnc 

echo working on FL TO FLNC for $SAMPLE...
mkdir ${FLNC}/${SAMPLE}
cd ${FL}/${SAMPLE}
echo you are in ${FL}/${SAMPLE}

for f in *.NEB_5p--NEB_Clontech_3p.bam
do
isoseq3 refine --require-polya ${f} ${PRIMERS} ${FLNC}/${SAMPLE}/${f%%.bam}.flnc.bam -j 12
done

# bam to fasta 

echo working on COMBINING FLNC MOVIES for $SAMPLE...
cd ${FLNC}/${SAMPLE}
echo you are in ${FLNC}/${SAMPLE}

for f in *.NEB_5p--NEB_Clontech_3p.flnc.bam
do
bamtools convert -format fasta -in $f > ${f%%.fl.NEB_5p--NEB_Clontech_3p.flnc.bam}.flnc.fasta 
done

# concatenate movies
echo you are in ${FLNC}/${SAMPLE}

cat *.flnc.fasta > $SAMPLE.flnc.fasta
