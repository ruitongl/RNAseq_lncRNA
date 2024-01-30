#!/bin/bash
#SBATCH --job-name=map_samples
#SBATCH --mail-user=ruitong.li@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=map_reads.out
#SBATCH --error=04_sample_alignment.err
#SBATCH --cpus-per-task=64
#SBATCH --mem=60G
#SBATCH --time=06:00:00

module load UHTS/Aligner/hisat/2.2.1
module load UHTS/Analysis/samtools/1.10

cd map_reads

THREADS=$SLURM_CPUS_PER_TASK

INDEX=/data/courses/rnaseq_course/lncRNAs/Project1/users/rli/index
READ_FILES=/data/courses/rnaseq_course/lncRNAs/fastq
OUTPUT=/data/courses/rnaseq_course/lncRNAs/Project1/users/rli/map_reads

hisat2 -p $THREADS -x $INDEX/Human_Genome -1 $READ_FILES/1_1_L3_R1_*.fastq.gz -2 $READ_FILES/1_1_L3_R2_*.fastq.gz -S $OUTPUT/1_1.sam
hisat2 -p $THREADS -x $INDEX/Human_Genome -1 $READ_FILES/1_2_L3_R1_*.fastq.gz -2 $READ_FILES/1_2_L3_R2_*.fastq.gz -S $OUTPUT/1_2.sam
hisat2 -p $THREADS -x $INDEX/Human_Genome -1 $READ_FILES/1_5_L3_R1_*.fastq.gz -2 $READ_FILES/1_5_L3_R2_*.fastq.gz -S $OUTPUT/1_5.sam

hisat2 -p $THREADS -x $INDEX/Human_Genome -1 $READ_FILES/P1_L3_R1_*.fastq.gz -2 $READ_FILES/P1_L3_R2_*.fastq.gz -S $OUTPUT/P1.sam
hisat2 -p $THREADS -x $INDEX/Human_Genome -1 $READ_FILES/P2_L3_R1_*.fastq.gz -2 $READ_FILES/P2_L3_R2_*.fastq.gz -S $OUTPUT/P2.sam
hisat2 -p $THREADS -x $INDEX/Human_Genome -1 $READ_FILES/P3_L3_R1_*.fastq.gz -2 $READ_FILES/P3_L3_R2_*.fastq.gz -S $OUTPUT/P3.sam