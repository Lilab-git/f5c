mkdir -p bam_output_nodup

for sam_file in bwa_output/*.sam; do
    prefix=$(basename "$sam_file" .sam)
    samtools view -bS "$sam_file" > "bam_output_nodup/${prefix}.bam"
    samtools sort "bam_output_nodup/${prefix}.bam" -o "bam_output_nodup/${prefix}.sorted.bam"
    samtools index "bam_output_nodup/${prefix}.sorted.bam"
    echo "Processed: $sam_file"
done
echo "Batch processing completed!"
