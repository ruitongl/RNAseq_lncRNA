#!/bin/bash
#SBATCH --job-name=build_bed_files
#SBATCH --mail-user=ruitong.li@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=build_bed_files.out
#SBATCH --error=build_bed_files.err
#SBATCH --cpus-per-task=2
#SBATCH --mem=4G
#SBATCH --time=01:00:00

ALL_GTF=/data/courses/rnaseq_course/lncRNAs/Project1/users/rli/transcriptome_assembly/total_merge.gtf
DIR_OUT=/data/courses/rnaseq_course/lncRNAs/Project1/users/rli/bed_files

# find transcripts on chromosomes and write them to bed file
# generate the bed file as: chromosomal position, start, end, gene name, score, strand, transcript id
awk '$1~/^chr/ && $3=="transcript" {if ($14!="") print $1,$4-1,$5,$14,$6,$7,$12; else print $1,$4-1,$5,$10,$6,$7,$12}' $ALL_GTF | sed 's/"//g' | sed 's/;//g' | sed 's/ /\t/g' > $DIR_OUT/all_transcripts.bed

# build bed files of novel and annotated transcripts
awk '$7~"MSTRG" {print $0}' $DIR_OUT/all_transcripts.bed > $DIR_OUT/novel_transcripts.bed
awk '$7~"ENST" {print $0}' $DIR_OUT/all_transcripts.bed > $DIR_OUT/annotated_transcripts.bed

# build 5' and 3' annotations for all the transcripts
# the window is set as -50 and +50 neucleotide around the start or end position
awk '{if ($5=="+") print $1,$2-50,$2+50,$4,$5,$6,$7; else print $1,$3-50,$3+50,$4,$5,$6,$7}' $DIR_OUT/all_transcripts.bed | awk '{if ($2<0) print $1,0,100,$4,$5,$6,$7; else print $0}' | sed 's/ /\t/g' > $DIR_OUT/5_prime.bed
awk '{if ($5=="+") print $1,$3-50,$3+50,$4,$5,$6,$7; else print $1,$2-50,$2+50,$4,$5,$6,$7}' $DIR_OUT/all_transcripts.bed | awk '{if ($2<0) print $1,0,100,$4,$5,$6,$7; else print $0}' | sed 's/ /\t/g' > $DIR_OUT/3_prime.bed