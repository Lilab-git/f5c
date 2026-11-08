#!/bin/bash

VARSCAN_DIR="varscan"
OUTPUT="varscan/summary_pos31_all_samples.tsv"

echo -e "Sample\tChrom\tPos\tRef\tAlt\tGT\tDP\tRD\tAD\tFreq" > $OUTPUT
for file in $VARSCAN_DIR/*.tsv; do
    sample=$(basename $file .tsv)
    line=$(sed -n '31p' $file)
    if [ -z "$line" ]; then
        echo -e "$sample\tNO_DATA" >> $OUTPUT
        continue
    fi
    chrom=$(echo "$line" | cut -f1)
    pos=$(echo "$line" | cut -f2)
    ref=$(echo "$line" | cut -f3)
    alt=$(echo "$line" | cut -f4)
    info=$(echo "$line" | cut -f5)
    IFS=':' read -r GT GQ SDP DP RD AD FREQ rest <<< "$info"
    echo -e "$sample\t$chrom\t$pos\t$ref\t$alt\t$GT\t$DP\t$RD\t$AD\t$FREQ" >> $OUTPUT
done
echo "saved:$OUTPUT"

