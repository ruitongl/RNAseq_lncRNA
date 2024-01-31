
setwd("G:/Study/Bern/1st semester/RNA Sequencing/Lnc-RNAs/rli")

### Load packages from library
library(tximport)
library(tximportData)
library(readr)
library(DESeq2)
library(EnhancedVolcano)

############ Gene and Transcript Level Differential Expression Analysis ############
### Set sample condition table
coldata <- data.frame(row.names = c("HOLO_1_1", "HOLO_1_2", "HOLO_1_5", "PARENTAL_1", "PARENTAL_2", "PARENTAL_3"),
                      group = factor(c(rep("holoclonal",3),rep("parental",3))))

### Load transcripts-genes table
trans_vs_genes <- read.table("G:/Study/Bern/1st semester/RNA Sequencing/Lnc-RNAs/rli/output/transcriptomes_to_genes.txt")
trans_to_genes <- data.frame(transcript_id = trans_vs_genes$V1,
                             gene_name = trans_vs_genes$V2)

### Set file paths
dir <- "G:/Study/Bern/1st semester/RNA Sequencing/Lnc-RNAs/rli/output/"
run_samples <- c("holo_1_1.tsv", "holo_1_2.tsv", "holo_1_5.tsv", "par_1.tsv", "par_2.tsv", "par_3.tsv")
files <- file.path(dir, run_samples)
names(files) <- c("HOLO_1_1", "HOLO_1_2", "HOLO_1_5", "PARENTAL_1", "PARENTAL_2", "PARENTAL_3")


##### Gene level DESeq2 analysis
txi <- tximport(files, type="kallisto", tx2gene=trans_to_genes)
ddsTxi <- DESeqDataSetFromTximport(txi, colData = coldata, design = ~ group)
dds <- DESeq(ddsTxi)
res <- results(dds)
summary(res)

### Output results that passed the cutoff padj<0.1 to table
gene_res <- subset(as.data.frame(res), padj < 0.1)
gene_matrix <- subset(as.data.frame(txi$counts), rownames(txi$counts) %in% rownames(gene_res))
write.csv(cbind(gene_matrix, gene_res), "gene_expression_table.csv")
write.table(rownames(txi$counts),"test.txt", sep=";",col.names = FALSE, row.names = FALSE)

### Volcano plot
EnhancedVolcano(gene_res, lab = rownames(gene_res),
                x = "log2FoldChange", y = "pvalue", title = "gene level holoclonal vs parental",
                legendPosition = 'right')

##### Transcript level DESeq2 analysis
txi_trans <- tximport(files, type="kallisto", tx2gene=trans_to_genes, txOut = TRUE)
ddsTxi_tx <- DESeqDataSetFromTximport(txi_trans, colData = coldata, design = ~ group)
dds_tx <- DESeq(ddsTxi_tx)
res_tx <- results(dds_tx)
summary(res_tx)

### Output results that passed the cutoff padj<0.1 to table
tx_res <- subset(as.data.frame(res_tx), padj < 0.1)
tx_matrix <- subset(as.data.frame(txi_trans$counts), rownames(txi_trans$counts) %in% rownames(tx_res))

write.csv(cbind(tx_matrix, tx_res), "transcript_expression_table.csv")

### Volcano plot
EnhancedVolcano(tx_res, lab = rownames(tx_res),
                x = "log2FoldChange", y = "pvalue", title = "transcript level holoclonal vs parental",
                legendPosition = 'right')


############ Novel Genes analysis ############
### Load list of novel transcript
novel_trans <- read.table("G:/Study/Bern/1st semester/RNA Sequencing/Lnc-RNAs/rli/output/novel_trans.txt")
novel_trans <- c(novel_trans$V1)

### novel transcripts 
txi_novel <- 

### build a subset of novel genes differential expression
novel_genes <- subset(trans_to_genes, trans_to_genes$transcript_id %in% novel_trans)
novel_gene_res <- subset(gene_res, rownames(gene_res) %in% novel_genes$gene_name)
novel_matrix <- subset(as.data.frame(txi$counts), rownames(txi$counts) %in% rownames(novel_gene_res))
write.csv(cbind(novel_matrix, novel_gene_res), "novel_gene_table.csv")


### Volcano plot of novel genes
EnhancedVolcano(novel_gene_res, lab = rownames(novel_gene_res),
                x = "log2FoldChange", y = "pvalue", title = "gene level holoclonal vs parental",
                legendPosition = 'right')

############
##### Using biomart to find details of genes

library('biomaRt')
library('dplyr')

ensembl <- biomaRt::useEnsembl(biomart = "genes")
ensembl <- useDataset(dataset = "hsapiens_gene_ensembl", mart = ensembl)

listAttributes(ensembl)
t2g <- biomaRt::getBM(attributes = c("ensembl_transcript_id", "ensembl_gene_id", "external_gene_name", "gene_biotype", "transcript_biotype", "hgnc_symbol"),
                      mart = ensembl, filters = "hgnc_symbol", values = rownames(txi$counts))
t2g <- dplyr::rename(t2g, target_id = ensembl_transcript_id, ens_gene = ensembl_gene_id, ext_gene = external_gene_name)


