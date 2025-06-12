#!/bin/bash
# download the data using wget get from the download files from the websites
# data are 2i&a2i&serum_0/1/2
mkdir fastqc
mkdir genome_star
mkdir alignment

fastqc --nogroup -o fastqc ./fastq/*.fastq
multiqc ./fastqc

mkdir annot
wget -P annot ftp://ftp.ensembl.org/pub/release-114/gtf/mus_musculus/Mus_musculus.GRCm39.114.gtf.gz

wget -P genome_star ftp://ftp.ensembl.org/pub/release-114/fasta/mus_musculus/dna/Mus_musculus.GRCm39.dna.primary_assembly.fa.gz

gunzip annot/*.gz
gunzip genome_star/*.gz

#generate genomeParameter.txt
STAR --runThreadN 10 \
     --runMode genomeGenerate \
     --genomeDir genome_star \
     --genomeFastaFiles genome_star/Mus_musculus.GRCm39.dna.primary_assembly.fa \
     --sjdbGTFfile annot/Mus_musculus.GRCm39.114.gtf \
     --sjdbOverhang 49
#after this we perform star alignment which is 

./run_star_all.sh
 
#alignment done
# perform count and mapping to the genome using R

#library(Rsubread)

# Define variables
#study <- "scRNAseq_mouse_esc"  # Replace with your actual study folder name
#annot <- "annot/Mus_musculus.GRCm39.114.gtf"  # GTF file path
#alignment_files <- list.files(path = "alignment", pattern = "\\.bam$", full.names = TRUE)
#> mytable_features <- featureCounts(
#  files = alignment_files,
#  annot.ext = annot,
#  isGTFAnnotationFile = TRUE,
#  isPairedEnd = TRUE,
#  countMultiMappingReads = FALSE,
#  minMQS = 30,
#  nthreads = 10,
#  minOverlap = 10
#)

