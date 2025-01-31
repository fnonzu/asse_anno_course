#!/usr/bin/env bash

#SBATCH --partition=pibu_el8
#SBATCH --job-name=orthofinder
#SBATCH --time=3-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --output=/data/users/mvolosko/asse_anno_course/annotations/logs/%j_output_orthofinder.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/annotations/logs/%j_error_orthofinder.e

# Load required modules
module load R/4.1.0-foss-2021a
module load UCSC-Utils/448-foss-2021a
module load MariaDB/10.6.4-GCC-10.3.0

# Set variables
WORK_DIR=/data/users/mvolosko/asse_anno_course/annotations/output/quality/parse_orthofinder
SCRIPT=/data/users/mvolosko/asse_anno_course/annotations/scripts/19-parse_Orthofinder.R
COURSEDIR=/data/courses/assembly-annotation-course/CDS_annotation

# Create required directories
mkdir -p $WORK_DIR $WORK_DIR/Plots
cd $WORK_DIR

# Run the R script
Rscript $SCRIPT

