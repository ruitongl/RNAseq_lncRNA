#!/bin/bash
#SBATCH --job-name=fastqc_samples
#SBATCH --mail-user=ruitong.li@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=fastqc_samples.out
#SBATCH --error=fastqc_samples.err
#SBATCH --cpus-per-task=4
#SBATCH --mem=4G
#SBATCH --time=01:00:00

module add UHTS/Quality_control/fastqc/0.11.7

READ_FILES=/data/courses/rnaseq_course/lncRNAs/fastq
# run fastqc for each replicate of parental and holoclonal samples
srun fastqc -o ./quality_control --noextract --threads 2 $READ_FILES/1_*.fastq.gz $READ_FILES/P*.fastq.gz