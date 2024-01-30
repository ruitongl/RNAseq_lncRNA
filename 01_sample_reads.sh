#!/usr/bin/env bash
#SBATCH --job-name=sample_read
#SBATCH --mail-user=ruitong.li@students.unibe.ch
#SBATCH --mail-type=begin,end,fail
#SBATCH --output=01_read_number.out
#SBATCH --error=sample_reads.err
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=4G
#SBATCH --time=00:25:00

READ_FILES=/data/courses/rnaseq_course/lncRNAs/fastq

# In fastq files, each read has four lines
# so total reads of a fastq data is the number of lines /4
for i in $READ_FILES/1_*.fastq.gz
do
    echo "${i}   $(zcat -c $i | echo `wc -l`/4 | bc -l)"
done

for i in $READ_FILES/P*.fastq.gz
do
    echo "${i}   $(zcat -c $i | echo `wc -l`/4 | bc -l)"
done