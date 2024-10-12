#!/bin/bash


#################################################################### ABOUT SCRIPT ############################################################################################

#Clean pacbio data by using isoseq3 package

#1. Create consensus sequences from subreads
#2. Remove adaptor from reads
#3. Remove poly-A tails
#4. Cluster similar reads
#5. Summarise the clean reads

##############################################################################################################################################################################


LIBRARY=$1 # sample name

echo working on $LIBRARY ...

##############################################################################################################################################################################

# Create directory for each ANALYSIS
# CCS FL, FLNC, Clustered
mkdir 1.CCS 2.FL 3.FLNC 4.Cluster 5.Summary

# DIRECTORIES
RAWDATA=/ISOseq/RawData
CCS=/ISOseq/1.CCS
FL=/ISOseq/2.FL
FLNC=/ISOseq/3.FLNC
CLUSTER=/ISOseq/4.Cluster
SUMMARY=/ISOseq/5.Summary
PRIMERS=/ISOseq/primers.fasta # you should have the primer.fasta in that location!

################################################# SUBREADS TO CCS ################################################

mkdir ${CCS}/${LIBRARY}

echo working on SUBREADS TO CCS... 
cd ${RAWDATA}/${LIBRARY}
echo you are in ${RAWDATA}/${LIBRARY}

for f in *.bam
do
# we are polishing data during this step
ccs ${f} ${CCS}/${LIBRARY}/${f%%.subreads.bam}.ccs.bam --min-passes 1 --min-rq 0.8 --max-drop-fraction 0.8 -j 8
done

################################################# CCS TO FL ################################################

mkdir ${FL}/${LIBRARY}

echo working on CCS TO FL...
cd ${CCS}/${LIBRARY}
echo you are in ${CCS}/${LIBRARY}

for f in *.bam
do
lima ${f} ${PRIMERS} ${FL}/${LIBRARY}/${f%%.ccs.bam}.fl.bam --isoseq --peek-guess --num-threads 8 --dump-clips --dump-removed --log-level INFO --log-file ${FL}/${LIBRARY}/${f%%.ccs.bam}.log
done

##############################################################################################################################################################################

################################################# FL TO FLNC ################################################

mkdir ${FLNC}/${LIBRARY}

echo working on FL TO FLNC...
cd ${FL}/${LIBRARY}
echo you are in ${FL}/${LIBRARY}

for f in *.NEB_5p--NEB_Clontech_3p.bam
do
isoseq3 refine --require-polya ${f} ${PRIMERS} ${FLNC}/${LIBRARY}/${f%%.bam}.flnc.bam -j 8 
done
##############################################################################################################################################################################

################################################# COMBINED ################################################

echo working on COMBINING FLNC MOVIES...
cd ${FLNC}/${LIBRARY}
echo you are in ${FLNC}/${LIBRARY}

#mkdir combined
#echo combined directory have been created...

ls *.flnc.bam > ${LIBRARY}.flnc.fofn

##############################################################################################################################################################################

################################################# FLNC TO CLUSTERED ################################################

mkdir ${CLUSTER}/${LIBRARY}

echo working on FLNC TO CLUSTERED...

isoseq3 cluster ${FLNC}/${LIBRARY}/${LIBRARY}.flnc.fofn ${CLUSTER}/${LIBRARY}/${LIBRARY}.clustered.bam --verbose --use-qvs -j 8

##############################################################################################################################################################################

################################################# SUMMARIZE ################################################

echo working on SUMMARY OF CLEAN READS...

isoseq3 summarize ${CLUSTER}/${LIBRARY}/${LIBRARY}.clustered.bam ${SUMMARY}/${LIBRARY}.summary.csv

##############################################################################################################################################################################
