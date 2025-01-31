#!/usr/bin/env bash
#SBATCH --time=1:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=aannotations
#SBATCH --output=/data/users/mvolosko/asse_anno_course/annotations/logs/output_tesorterabundplot_%j.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/annotations/logs/error_tesorterabundplot_%j.e
#SBATCH --partition=pibu_el8

# Load required module
module load R/4.2.1-foss-2021a

# Run R script
Rscript 04.11.TE_abundance_plot.R
