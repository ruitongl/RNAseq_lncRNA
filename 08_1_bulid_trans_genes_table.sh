#!/bin/bash
#SBATCH --job-name=trans_to_genes
#SBATCH --mail-user=ruitong.li@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=trans_to_genes.out
#SBATCH --error=trans_to_genes.err
#SBATCH --cpus-per-task=1
#SBATCH --mem=6G
#SBATCH --time=00:10:00

TRANSCRIPTOME=/data/courses/rnaseq_course/lncRNAs/Project1/users/rli/expression/transcriptome.fa

# build a list that guide transcipts to the corresponding gene
awk '$2 ~ "gene" {print $1,$2}' $TRANSCRIPTOME | awk -F '>' '{print $NF}' | awk -F ' gene=' '{print $1,$2}' > transcriptomes_to_genes.txt