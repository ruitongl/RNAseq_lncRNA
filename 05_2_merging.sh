#!/bin/bash
#SBATCH --job-name=trasncriptome_assembly
#SBATCH --mail-user=ruitong.li@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=assembly.out
#SBATCH --error=assembly.err
#SBATCH --cpus-per-task=12
#SBATCH --mem=20G
#SBATCH --time=00:30:00

module load UHTS/Aligner/stringtie/1.3.3b
module load UHTS/Analysis/samtools/1.10

THREADS=$SLURM_CPUS_PER_TASK

REF=/data/courses/rnaseq_course/lncRNAs/Project1/references
READ_ANN=/data/courses/rnaseq_course/lncRNAs/Project1/users/rli/transcriptome_assembly

#find ./transcriptome* -name 1*.gtf > holo.txt
#find ./transcriptome* -name P*.gtf > parental.txt
#find ./transcriptome* -name *.gtf > all.txt

stringtie --merge -p $THREADS -G $REF/gencode.v44.chr_patch_hapl_scaff.annotation.gtf -o $READ_ANN/holoclone_merge.gtf holo.txt
stringtie --merge -p $THREADS -G $REF/gencode.v44.chr_patch_hapl_scaff.annotation.gtf -o $READ_ANN/parental_merge.gtf parental.txt
stringtie --merge -p $THREADS -G $REF/gencode.v44.chr_patch_hapl_scaff.annotation.gtf -o $READ_ANN/total_merge.gtf all.txt