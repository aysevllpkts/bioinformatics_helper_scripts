####################################
# Checking the error about read ID #
####################################

import argparse 
import pandas as pd
import matplotlib.pyplot as plt
from Bio import SeqIO 

# initialize parser
parser = argparse.ArgumentParser(description="small script for summary of the Iso-seq reads")
# add arguments
parser.add_argument("-i","--input", type=str, required=True, help="The file that contains transcript sequences")
parser.add_argument("-f","--format", type=str, required=True, help="The format of the file fasta or fastq")
parser.add_argument("-b","--bins", type=int, required=True, help="bins for the plot")
parser.add_argument("-o","--output", type=str, required=True, help="name for the plot")
parser.add_argument("-out_dir","--output_directory", type=str, required=True, help="location of the output file")
#parser.add_argument("-o","--output", type=str, required=True, help="The txt file contains INFO about number of small characters in the sequences")

# parse the argument
args=parser.parse_args()

file=args.input 

length = 0
total_transcript = 0
# for dataframe
lst = []

if args.format == "fasta":
  for seq_record in SeqIO.parse(open(file),'fasta'):
      #print("Name of the transcript: {}".format(seq_record.id))
      #print("Sequence: {}".format(repr(seq_record.seq)))
      transcript=seq_record.seq
      #print("Length of the transcript: {}".format(len(seq_record)))
      length += len(seq_record)
      total_transcript += 1
    
      # for dataframe
      lst.append([seq_record.id, len(seq_record)])

else:
  for seq_record in SeqIO.parse(open(file),'fastq'):
      transcript=seq_record.seq
      
      length += len(seq_record)
      total_transcript += 1
    
      # for dataframe
      lst.append([seq_record.id, len(seq_record)])


# WORK for both 

# dataframe
cols = ["transcript", "length"]
df = pd.DataFrame(lst, columns=cols)
df.to_csv(args.output_directory+"/"+args.output+".csv", index=False)
# Histogram of 'length' column
df.hist(column='length', bins=args.bins)
plt.savefig(args.output_directory+"/"+args.output+"_read_length.png")

# summary
print("nb of nucleotides: {}".format(length))
print("average length: {}".format(length/total_transcript))
print("nb of transcripts: {}".format(total_transcript))    
print("min length: {}".format(df['length'].min()))
print("max length: {}".format(df['length'].max()))

