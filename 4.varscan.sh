#!/bin/bash

REF="NC_012920.1.fasta"
VARSCAN="/path/to/VarScan.v2.3.9.jar"
BAM_DIR="bam_output_nodup"
OUT_DIR="varscan"
BAM_SUFFIX=".sorted.bam"

mkdir -p ${OUT_DIR}

for bam in ${BAM_DIR}/*${BAM_SUFFIX}; do
    sample=$(basename ${bam} ${BAM_SUFFIX})
    samtools mpileup -B -q 10 -Q 20 -f ${REF} ${bam} \
    | java -jar ${VARSCAN} mpileup2cns \
        --min-coverage 100 \
        --min-var-freq 0.01 \
        --min-reads2 10 \
        --min-avg-qual 20 \
        --p-value 0.99 \
        --output-vcf 1 \
    | grep -v '^#' \
    | awk 'BEGIN{FS="\t";OFS="\t"}{print $1,$2,$4,$5,$10}' \
    > ${OUT_DIR}/${sample}.tsv
    
    echo "${sample} save: ${OUT_DIR}/${sample}.tsv"
done

