#!/bin/bash
#SBATCH --job-name=coding_potential
#SBATCH --mail-user=ruitong.li@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=coding_potential.out
#SBATCH --error=coding_potential.err
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --time=01:00:00

module load UHTS/Analysis/BEDTools/2.29.2
module load SequenceAnalysis/GenePrediction/cpat/1.2.4

DIR_BED=/data/courses/rnaseq_course/lncRNAs/Project1/users/rli/bed_files
REF=/data/courses/rnaseq_course/lncRNAs/Project1/references
DIR_OUT=/data/courses/rnaseq_course/lncRNAs/Project1/users/rli/coding_potential

# generate a fasta file of novel transcripts
bedtools getfasta -fi $REF/GRCh38.genome.fa -bed $DIR_BED/novel_transcripts.bed -s -fo $DIR_OUT/novel_transcripts.fa

# run cpat
cpat.py -x $REF/Human_Hexamer.tsv -d $REF/Human_logitModel.RData -g $DIR_OUT/novel_transcripts.fa -o $DIR_OUT/novel_transcripts.output
