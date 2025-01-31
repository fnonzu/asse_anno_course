#!/usr/bin/env bash
#SBATCH --time=1:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=prepare_ideogram
#SBATCH --output=/data/users/mvolosko/asse_anno_course/annotations/logs/output_ideogram_%j.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/annotations/logs/error_ideogram_%j.e
#SBATCH --partition=pibu_el8

# Load necessary module for samtools
module load SAMtools/1.13-GCC-10.3.0

# Define file paths
assembly_fasta="/data/users/mvolosko/asse_anno_course/data/results/assembly_flye/assembly.fasta"
fai_file="/data/users/mvolosko/asse_anno_course/annotations/output"

# Generate the .fai file
samtools faidx $assembly_fasta -o $fai_file
