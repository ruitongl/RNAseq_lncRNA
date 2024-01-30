#!/bin/bash
#SBATCH --job-name=integrative_analysis
#SBATCH --mail-user=ruitong.li@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=find_intergenic.out
#SBATCH --error=find_intergenic.err
#SBATCH --cpus-per-task=2
#SBATCH --mem=4G
#SBATCH --time=00:10:00

module load UHTS/Analysis/BEDTools/2.29.2

DIR_BED=/data/courses/rnaseq_course/lncRNAs/Project1/users/rli/bed_files

# find the intergenic novel transcript
# compare novel transcripts to annotative transcripts and produce a bed file of non-overlapping transcripts by -v option
# no matter the overlapped feature are on the same strand or not, it will be considered an overlap
bedtools intersect -a $DIR_BED/novel_transcripts.bed -b $DIR_BED/annotated_transcripts.bed -v > $DIR_BED/intergenic_novel.bed
