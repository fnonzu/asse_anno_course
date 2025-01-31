#!/usr/bin/env bash
#SBATCH --time=1:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=aannotations
#SBATCH --output=/data/users/mvolosko/asse_anno_course/annotations/logs/output_edta_%j.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/annotations/logs/error_edta_%j.e
#SBATCH --partition=pibu_el8

# Step 1: Extract Percent identity from GFF3
#gff3_file="/data/users/mvolosko/asse_anno_course/annotations/output/EDTA_annotation/assembly.fasta.mod.EDTA.raw/assembly.fasta.mod.LTR.intact.raw.gff3"
#output_identity="percent_identity.tsv"

cd /data/users/mvolosko/asse_anno_course/annotations/output
# extract identity
#awk -F"[=;]" '{print $4, $13}' $gff3_file > $output_identity

# Step 2: Split LTRs into clades
#clade_file="/data/users/mvolosko/asse_anno_course/annotations/output/EDTA_annotation/assembly.fasta.mod.EDTA.raw/LTR/assembly.fasta.mod.LTR.intact.fa.ori.dusted.cln.rexdb.cls.tsv"
#clade_output="clades_output.tsv"

# Command to split the file based on clades
#awk -F"#" '{print $1, $4}' clades_output.tsv > clades_cleaned.tsv

# Step 3: Plot the data
module load R/4.2.1-foss-2021a  # Load R module if available, or python if using matplotlib

Rscript /data/users/mvolosko/asse_anno_course/annotations/scripts/plot_ltr_clades.R

