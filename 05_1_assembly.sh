#!/bin/bash
#SBATCH --job-name=trasncriptome_assembly
#SBATCH --mail-user=ruitong.li@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=assembly.out
#SBATCH --error=assembly.err
#SBATCH --cpus-per-task=32
#SBATCH --mem=40G
#SBATCH --time=03:00:00

module load UHTS/Aligner/stringtie/1.3.3b
module load UHTS/Analysis/samtools/1.10

THREADS=$SLURM_CPUS_PER_TASK
INPUT_FILE=/data/courses/rnaseq_course/lncRNAs/Project1/users/rli/map_reads
REF_ANN=/data/courses/rnaseq_course/lncRNAs/Project1/references
DIR_OUT=/data/courses/rnaseq_course/lncRNAs/Project1/users/rli/transcriptome_assembly

for file in $INPUT_FILE/*_sorted.bam
do
  stringtie -o $DIR_OUT/${file%_sorted.bam}.gtf --rf -p $THREADS -G $REF_ANN/gencode.v44.chr_patch_hapl_scaff.annotation.gtf $file
done