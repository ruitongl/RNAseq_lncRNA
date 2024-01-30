#!/bin/bash
#SBATCH --job-name=sorting_reads
#SBATCH --mail-user=ruitong.li@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=sort.out
#SBATCH --error=sort.err
#SBATCH --cpus-per-task=64
#SBATCH --mem=60G
#SBATCH --time=03:00:00

module load UHTS/Aligner/hisat/2.2.1
module load UHTS/Analysis/samtools/1.10

THREADS=$SLURM_CPUS_PER_TASK

INDEX=/data/courses/rnaseq_course/lncRNAs/Project1/users/rli/index
READ_FILES=/data/courses/rnaseq_course/lncRNAs/fastq
OUTPUT=/data/courses/rnaseq_course/lncRNAs/Project1/users/rli/map_reads

for file in $OUTPUT/*.sam
do
    samtools sort $file -@ $THREADS -o ${file%.sam}_sorted.bam --write-index
done