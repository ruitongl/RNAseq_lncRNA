#!/bin/bash
#SBATCH --job-name=quantification
#SBATCH --mail-user=ruitong.li@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=quantification.out
#SBATCH --error=quantification.err
#SBATCH --cpus-per-task=16
#SBATCH --mem=60G
#SBATCH --time=03:00:00

module load UHTS/Analysis/kallisto/0.46.0

THREADS=$SLURM_CPUS_PER_TASK

WORK_DIR=/data/courses/rnaseq_course/lncRNAs/Project1/users/rli/expression
FASTQ=/data/courses/rnaseq_course/lncRNAs/fastq

kallisto quant -t $THREADS -i $WORK_DIR/kallisto_index -o $WORK_DIR/holo_1_1 -b 100 --rf-stranded $FASTQ/1_1_L3_R1_001_ij43KLkHk1vK.fastq.gz $FASTQ/1_1_L3_R2_001_qyjToP2TB6N7.fastq.gz
kallisto quant -t $THREADS -i $WORK_DIR/kallisto_index -o $WORK_DIR/holo_1_2 -b 100 --rf-stranded $FASTQ/1_2_L3_R1_001_DnNWKUYhfc9S.fastq.gz $FASTQ/1_2_L3_R2_001_SNLaVsTQ6pwl.fastq.gz
kallisto quant -t $THREADS -i $WORK_DIR/kallisto_index -o $WORK_DIR/holo_1_5 -b 100 --rf-stranded $FASTQ/1_5_L3_R1_001_iXvvRzwmFxF3.fastq.gz $FASTQ/1_5_L3_R2_001_iXCMrktKyEh0.fastq.gz
kallisto quant -t $THREADS -i $WORK_DIR/kallisto_index -o $WORK_DIR/par_1 -b 100 --rf-stranded $FASTQ/P1_L3_R1_001_9L0tZ86sF4p8.fastq.gz $FASTQ/P1_L3_R2_001_yd9NfV9WdvvL.fastq.gz
kallisto quant -t $THREADS -i $WORK_DIR/kallisto_index -o $WORK_DIR/par_2 -b 100 --rf-stranded $FASTQ/P2_L3_R1_001_R82RphLQ2938.fastq.gz $FASTQ/P2_L3_R2_001_06FRMIIGwpH6.fastq.gz
kallisto quant -t $THREADS -i $WORK_DIR/kallisto_index -o $WORK_DIR/par_3 -b 100 --rf-stranded $FASTQ/P3_L3_R1_001_fjv6hlbFgCST.fastq.gz $FASTQ/P3_L3_R2_001_xo7RBLLYYqeu.fastq.gz