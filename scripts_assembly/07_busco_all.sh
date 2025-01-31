#!/usr/bin/env bash

# Set result directories
FLYE_RESULTDIR=/data/users/mvolosko/asse_anno_course/data/results/busco_flye/BUSCO_flye
HIFIASM_RESULTDIR=/data/users/mvolosko/asse_anno_course/data/results/busco_hifiasm/BUSCO_hifiasm
LJA_RESULTDIR=/data/users/mvolosko/asse_anno_course/data/results/busco_lja/BUSCO_lja

# Extract key metrics from BUSCO summary files
echo -e "Assembly\tComplete\tDuplicated\tFragmented\tMissing" > busco_summary.tsv

for resultdir in $FLYE_RESULTDIR $HIFIASM_RESULTDIR $LJA_RESULTDIR; do
    assembly=$(basename $resultdir | sed 's/busco_//')  # Extract the assembly name from the folder name
    short_summary="$resultdir/short_summary*.txt"      # BUSCO short summary file
    complete=$(grep "Complete BUSCOs" $short_summary | awk '{print $1}')
    duplicated=$(grep "Duplicated BUSCOs" $short_summary | awk '{print $1}')
    fragmented=$(grep "Fragmented BUSCOs" $short_summary | awk '{print $1}')
    missing=$(grep "Missing BUSCOs" $short_summary | awk '{print $1}')
    
    # Append results to the summary table
    echo -e "$assembly\t$complete\t$duplicated\t$fragmented\t$missing" >> busco_summary.tsv
done

# Display the summary
cat busco_summary.tsv
