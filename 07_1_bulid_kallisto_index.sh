#!/bin/bash
#SBATCH --job-name=run_kallisto
#SBATCH --mail-user=ruitong.li@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=kallisto.out
#SBATCH --error=kallisto.err
#SBATCH --cpus-per-task=16
#SBATCH --mem=60G
#SBATCH --time=03:00:00

module load UHTS/Analysis/kallisto/0.46.0
module load UHTS/Assembler/cufflinks/2.2.1

THREADS=$SLURM_CPUS_PER_TASK

OUT_DIR=/data/courses/rnaseq_course/lncRNAs/Project1/users/rli/expression
REF=/data/courses/rnaseq_course/lncRNAs/Project1/references
ANN=/data/courses/rnaseq_course/lncRNAs/Project1/users/rli/transcriptome_assembly

#build transcriptome fasta
gffread -w $OUT_DIR/transcriptome.fa -g $REF/GRCh38.genome.fa $ANN/total_merge.gtf

#bulid kallisto index
kallisto index -i $OUT_DIR/kallisto_index $OUT_DIR/transcriptome.fa