#!/bin/bash

########### MAP to GENOME #############

GENOME=$1
FASTA=$2
OUT=$3

minimap2 -ax splice -t 12 -uf --secondary=no ${GENOME} ${FASTA} > ${OUT}
sort -k 3,3 -k 4,4n ${OUT} > ${OUT%%.sam}.sorted.sam
# Now we will use the script get_bad_or_unmapped_hq.py to fish out the unmapped or badly mapped transcripts.
collapse_isoforms_by_sam.py --input ${FASTA} -s ${OUT%%.sam}.sorted.sam -c 0.99 -i 0.95 --max_5_diff 10000 --max_3_diff 1000 -o ${OUT%%.sorted.sam}.collapse.5merge
# get unmapped reads
python $COGENT/Cogent/helper_scripts/get_bad_or_unmapped_hq.py $FASTA ${OUT%%.sorted.sam}.collapse.5merge


# Create partition - for LARGE dataset
python run_preCluster.py --cpus=20 

# Create cmd file
IN_DIR=/home/aysevil/MolGen/faststorage/aysevil/Assemblies/merged_pacbio_trinity/cogent
python /home/aysevil/miniconda3/envs/anaCogent/bin/generate_batch_cmd_for_Cogent_family_finding.py --cpus=2 --cmd_filename=cmd_3 $IN_DIR/preCluster.cluster_info.csv $IN_DIR/preCluster_out $IN_DIR/greenland_shark_batches
  
python $COGENT/Cogent/helper_scripts/tally_Cogent_contigs_per_family.py output_dir/ organism_of_interest organism_output


# collapsing redundant isoforms
COGENT_GENOME=$1
TRANSCRIPTOME=$2
OUT=$3

minimap2 -ax splice -t 20 -uf --secondary=no $COGENT_GENOME $TRANSCRIPTOME > $OUT
sort -k 3,3 -k 4,4n $OUT > ${OUT%%.sam}.sorted.sam

collapse_isoforms_by_sam.py --input $TRANSCRIPTOME -s ${OUT%%.sam}.sorted.sam \
           -c 0.95 -i 0.85 --dun-merge-5-shorter \
           -o ${TRANSCRIPTOME%%.fasta}.no5merge