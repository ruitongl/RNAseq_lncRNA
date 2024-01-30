#!/bin/bash
#SBATCH --job-name=end_annotation
#SBATCH --mail-user=ruitong.li@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=end_annotation_analysis.out
#SBATCH --error=end_annotation_analysis.err
#SBATCH --cpus-per-task=2
#SBATCH --mem=4G
#SBATCH --time=00:10:00

module load UHTS/Analysis/BEDTools/2.29.2

DIR_BED=/data/courses/rnaseq_course/lncRNAs/Project1/users/rli/bed_files
FIVE_PRIME_REF=/data/courses/rnaseq_course/lncRNAs/Project1/references/refTSS_v4.1_human_coordinate.hg38.bed
THREE_PRIME_REF=/data/courses/rnaseq_course/lncRNAs/Project1/references/atlas.clusters.2.0.GRCh38.96.bed

# 5' and 3' annotation analysis
# only consider overlaps that transcripts and references are on the same strand
bedtools intersect -a $DIR_BED/5_prime.bed -b $FIVE_PRIME_REF -wa > $DIR_BED/annotative_5_prime.bed
bedtools intersect -a $DIR_BED/3_prime.bed -b $THREE_PRIME_REF -wa > $DIR_BED/annotative_3_prime.bed
