#!/bin/bash
#SBATCH --job-name=build_index
#SBATCH --mail-user=ruitong.li@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=build_index.out
#SBATCH --error=build_index.err
#SBATCH --cpus-per-task=16
#SBATCH --mem=16G
#SBATCH --time=03:00:00

THREADS=$SLURM_CPUS_PER_TASK

module load UHTS/Aligner/hisat/2.2.1

READ_REF=/data/courses/rnaseq_course/lncRNAs/Project1/references
INDEX=/data/courses/rnaseq_course/lncRNAs/Project1/users/rli/index

hisat2-build -p $THREADS -f $READ_REF/GRCh38.genome.fa $INDEX/Human_Genome





