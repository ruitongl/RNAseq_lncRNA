#!/bin/bash
#SBATCH --job-name=trans_to_genes
#SBATCH --mail-user=ruitong.li@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=trans_to_genes.out
#SBATCH --error=trans_to_genes.err
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=00:10:00

ALL=/data/courses/rnaseq_course/lncRNAs/Project1/users/rli/transcriptome_assembly/total_merge.gtf

# find novel transcripts with more than one exons
awk '$3=="exon" && $12~"MSTRG" {print $12}' $ALL | sort | uniq -d | sed 's/"//g' | sed 's/;//g' > novel_trans.txt