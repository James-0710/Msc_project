#!/bin/bash

# Set number of threads and paths
THREADS=10
GTF="annot/Mus_musculus.GRCm39.114.gtf"
GENOME_DIR="genome_star"
FASTQ_DIR="fastq"
OUT_DIR="alignment"

mkdir -p "$OUT_DIR"

# Loop over all *_1.fastq files
for R1 in ${FASTQ_DIR}/*_1.fastq; do
    # Extract sample name by removing _1.fastq
    SAMPLE=$(basename "$R1" _1.fastq)
    R2=${FASTQ_DIR}/${SAMPLE}_2.fastq

    # Check that R2 exists
    if [[ -f "$R2" ]]; then
        echo "Running STAR for sample: $SAMPLE"

        STAR --runThreadN "$THREADS" \
             --sjdbOverhang 49 \
             --sjdbGTFfile "$GTF" \
             --genomeDir "$GENOME_DIR" \
             --readFilesIn "$R1" "$R2" \
             --outSAMtype BAM SortedByCoordinate \
             --outFileNamePrefix ${OUT_DIR}/${SAMPLE}_
    else
        echo "Missing R2 for $SAMPLE — skipping."
    fi
done
