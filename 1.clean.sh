#!/bin/bash

mkdir -p clean logs

for R1 in rawdata/*.R1.fastq.gz; do
	R2="${R1/.R1.fastq.gz/.R2.fastq.gz}"
	prefix=$(basename "$R1" .R1.fastq.gz)
	fastp -i "$R1" -I "$R2" \
		-o "clean/${prefix}.R1.trimmed.fastq.gz" \
		-O "clean/${prefix}.R2.trimmed.fastq.gz" \
		--n_base_limit 5 \
		--cut_right \
		--cut_tail \
		--cut_window_size 4 \
		--cut_mean_quality 25 \
		--trim_poly_g \
		--poly_x_min_len 15 \
		--length_required 20 \
		--trim_front1 6 \
		--trim_front2 6 \
		--thread 16 \
		--html "logs/${prefix}_clean.html" \
		--json "logs/${prefix}_clean.json"
	done
