#!/bin/bash
#SBATCH --job-name=summarize
#SBATCH --output=12_summary.out
#SBATCH --error=summarize.err
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=00:10:00

DIR_BED=/data/courses/rnaseq_course/lncRNAs/Project1/users/rli/bed_files

# computing numbers of total, annotated, novel and intergenic novel transcripts
total_transcripts=$(wc -l $DIR_BED/all_transcripts.bed | cut -d ' ' -f 1)
annotative_transcripts=$(wc -l $DIR_BED/annotated_transcripts.bed | cut -d ' ' -f 1)
novel_transcripts=$(wc -l $DIR_BED/novel_transcripts.bed | cut -d ' ' -f 1)
intergenic_transcripts=$(wc -l $DIR_BED/intergenic_novel.bed | cut -d ' ' -f 1)
# calculating the percentage of novel transcripts
novel_percentage=$(echo "scale=4;${novel_transcripts}/${total_transcripts}*100"|bc)
# calculating percentage of non-overlapping novel transcripts
intergenic_percentage=$(echo "scale=4;${intergenic_transcripts}/${novel_transcripts}*100"|bc)

echo "${total_transcripts} total transcripts"
echo "${annotative_transcripts} transcripts are annotative"
echo "${novel_transcripts} transcripts (${novel_percentage} % of total) do not match a reference"
echo "${intergenic_transcripts} transcripts (${intergenic_percentage} % of total novel) do not overlap with annotated transcripts"
echo ""

# computing gene level results
total_genes=$(awk '{print $4}' $DIR_BED/all_transcripts.bed | sort | uniq -c | wc -l)
novel_genes=$(awk '{print $4}' $DIR_BED/novel_transcripts.bed | sort | uniq -c | wc -l)
intergenic_genes=$(awk '{print $4}' $DIR_BED/intergenic_novel.bed | sort | uniq -c | wc -l)
novel_gene_percentage=$(echo "scale=4;${novel_genes}/${total_genes}*100" | bc)
intergenic_gene_percentage=$(echo "scale=4;${intergenic_genes}/${novel_genes}*100" | bc)

echo "${total_genes} total genes"
echo "${novel_genes} novel genes (${novel_gene_percentage} % of total genes)"
echo "${intergenic_genes} intergenics (${intergenic_gene_percentage} % of total novel genes)"
echo ""

# 5' and 3' annotation quality analysis
annotated_5_prime=$(wc -l $DIR_BED/annotative_5_prime.bed | cut -d ' ' -f 1)
annotated_3_prime=$(wc -l $DIR_BED/annotative_3_prime.bed | cut -d ' ' -f 1)
correct_5_prime_percentage=$(echo "scale=4;${annotated_5_prime}/${total_transcripts}*100" | bc)
correct_3_prime_percentage=$(echo "scale=4;${annotated_3_prime}/${total_transcripts}*100" | bc)

echo "${annotated_5_prime} transcripts (${correct_5_prime_percentage} % of total) have correct annotated 5' ends"
echo "${annotated_3_prime} transcripts (${correct_3_prime_percentage} % of total) have correct annotated 3' ends"