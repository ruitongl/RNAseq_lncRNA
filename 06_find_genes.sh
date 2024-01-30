#!/bin/bash
#SBATCH --job-name=find
#SBATCH --output=06_find_genes.out
#SBATCH --error=find_genes.err
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=00:10:00

HOLO=/data/courses/rnaseq_course/lncRNAs/Project1/users/rli/transcriptome_assembly/holoclone_merge.gtf
PAR=/data/courses/rnaseq_course/lncRNAs/Project1/users/rli/transcriptome_assembly/parental_merge.gtf
ALL=/data/courses/rnaseq_course/lncRNAs/Project1/users/rli/transcriptome_assembly/total_merge.gtf

#computing exons, transcripts and in holoclonal assembly
holo_exons=$(awk '$3=="exon"' $HOLO | wc -l)
holo_transcripts=$(awk '$3=="transcript"' $HOLO | wc -l)
holo_genes=$(awk '$3=="transcript" {print $10}' $HOLO | sort | uniq -c | wc -l)
#finding novel genes
holo_novel=$(awk '$3=="transcript" && $12~/MSTRG/' $HOLO | wc -l)
#finding transcripts and genes that only have one exon
holo_single_exon_transcripts=$(awk '$3=="exon" {print $12}' $HOLO | sort | uniq -c | awk '$1==1' | wc -l)
holo_single_exon_genes=$(awk '$3=="exon" {print $10}' $HOLO | sort | uniq -c | awk '$1==1' | wc -l)

#print to the output file
echo 'Holoclones'
echo "${holo_exons} exons"
echo "${holo_transcripts} transcripts"
echo "${holo_genes} genes"
echo "${holo_novel} novel genes"
echo "${holo_single_exon_transcripts} transcripts that have one exon"
echo "${holo_single_exon_genes} genes that have one exon"
echo ""

#computing exons, transcripts and in parental assembly
par_exons=$(awk '$3=="exon"' $PAR | wc -l)
par_transcripts=$(awk '$3=="transcript"' $PAR | wc -l)
par_genes=$(awk '$3=="transcript" {print $10}' $PAR | sort | uniq -c | wc -l)
#finding novel genes
par_novel=$(awk '$3=="transcript" && $12~/MSTRG/' $PAR | wc -l)
#finding transcripts and genes that only have one exon
par_single_exon_transcripts=$(awk '$3=="exon" {print $12}' $PAR | sort | uniq -c | awk '$1==1' | wc -l)
par_single_exon_genes=$(awk '$3=="exon" {print $10}' $PAR | sort | uniq -c | awk '$1==1' | wc -l)

#print to the output file
echo 'Parental'
echo "${par_exons} exons"
echo "${par_transcripts} transcripts"
echo "${par_genes} genes"
echo "${par_novel} novel genes"
echo "${par_single_exon_transcripts} transcripts that have one exon"
echo "${par_single_exon_genes} genes that have one exon"
echo ""

#computing exons, transcripts and in total assembly
all_exons=$(awk '$3=="exon"' $ALL | wc -l)
all_transcripts=$(awk '$3=="transcript"' $ALL | wc -l)
all_genes=$(awk '$3=="transcript" {print $10}' $ALL | sort | uniq -c | wc -l)
#finding novel genes
all_novel=$(awk '$3=="transcript" && $12~/MSTRG/' $ALL | wc -l)
#finding transcripts and genes that only have one exon
all_single_exon_transcripts=$(awk '$3=="exon" {print $12}' $ALL | sort | uniq -c | awk '$1==1' | wc -l)
all_single_exon_genes=$(awk '$3=="exon" {print $10}' $ALL | sort | uniq -c | awk '$1==1' | wc -l)

#print to the output file
echo 'Holo & Parental'
echo "${all_exons} exons"
echo "${all_transcripts} transcripts"
echo "${all_genes} genes"
echo "${all_novel} novel genes"
echo "${all_single_exon_transcripts} transcripts that have one exon"
echo "${all_single_exon_genes} genes that have one exon"
