#!/bin/bash

REFERENCE="NC_012920.1.fasta"
# bwa index "$REFERENCE"
mkdir -p bwa_output

for R1 in ./clean/*.R1.trimmed.fastq.gz; do
	prefix=$(basename "$R1" .R1.trimmed.fastq.gz)
	R2="./clean/${prefix}.R2.trimmed.fastq.gz"
	bwa mem "$REFERENCE" "$R1" "$R2" > "bwa_output/${prefix}.sam"
done
