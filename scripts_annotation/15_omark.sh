#!/usr/bin/env bash

#SBATCH --partition=pibu_el8
#SBATCH --job-name=omark
#SBATCH --time=10:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --output=/data/users/mvolosko/asse_anno_course/annotations/logs/%j_output_omark.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/annotations/logs/%j_error_omark.e

# Load modules or activate environment (adjusted for your course)
# Uncomment the following line if you need a conda environment
eval "$(/home/amaalouf/miniconda3/bin/conda shell.bash hook)"
conda activate OMArk

# Set variables
WORK_DIR=/data/users/mvolosko/asse_anno_course/annotations/output/quality/omark
ORIG_PROT_FA=/data/users/mvolosko/asse_anno_course/annotations/output/final/proteins.longest.fasta
ORIG_PROT_FAI=/data/users/mvolosko/asse_anno_course/annotations/output/final/assembly.all.maker.proteins.fasta.renamed.filtered.fasta.fai
OMAMER_PROT=/data/users/mvolosko/asse_anno_course/annotations/output/quality/omark/proteins.longest.fasta.omamer
INPUT_FILE=/data/users/mvolosko/asse_anno_course/annotations/output/quality/omark/all_isoforms.txt
OUTPUT_FILE=/data/users/mvolosko/asse_anno_course/annotations/output/quality/omark/all_isoforms.splice

# Create working directory
mkdir -p $WORK_DIR
cd $WORK_DIR

# Step 1: Run OMAmer search
omamer search --db LUCA.h5 --query $ORIG_PROT_FA --out $OMAMER_PROT

# Step 2: Extract protein IDs for isoform processing
cut -f1 $ORIG_PROT_FAI > $INPUT_FILE

# Step 3: Group isoforms by gene
declare -A gene_map

# Read each line from the input file
while IFS= read -r protein_id; do
    # Extract gene prefix (part before "-R")
    gene_prefix=$(echo "$protein_id" | sed -E 's/(-R.*)//')
    
    # Append protein ID to the corresponding gene key
    if [[ -z "${gene_map[$gene_prefix]}" ]]; then
        gene_map[$gene_prefix]="$protein_id"
    else
        gene_map[$gene_prefix]+=";$protein_id"
    fi
done < "$INPUT_FILE"

# Write the grouped isoforms to the output file
> "$OUTPUT_FILE"  # Clear the file if it exists
for gene in "${!gene_map[@]}"; do
    echo "${gene_map[$gene]}" >> "$OUTPUT_FILE"
done

# Step 4: Run OMArk
omark -f $OMAMER_PROT \
 -of $ORIG_PROT_FA \
 -i $OUTPUT_FILE \
 -d LUCA.h5 \
 -o omark_output

