#!/usr/bin/env bash

#SBATCH --partition=pibu_el8
#SBATCH --job-name=riparian_plot
#SBATCH --time=3-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --output=/data/users/mvolosko/asse_anno_course/annotations/logs/%j_output_riparian_plot.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/annotations/logs/%j_error_riparian_plot.e

# Load module
module load R/4.1.0-foss-2021a

# Set variables
WORK_DIR=/data/users/mvolosko/asse_anno_course/annotations/output/quality/riparian_plot
SCRIPT=/data/users/mvolosko/asse_anno_course/annotations/scripts/025-riparian_plot.R
COURSEDIR=/data/courses/assembly-annotation-course/CDS_annotation
CONTAINER=/data/courses/assembly-annotation-course/CDS_annotation/containers/genespace_latest.sif

# Create working directory
mkdir -p $WORK_DIR
cd $WORK_DIR

# Run the R script using Apptainer and the specified container
apptainer exec \
    --bind $COURSEDIR \
    --bind $WORK_DIR \
    --bind $SCRATCH:/temp \
    $CONTAINER \
    Rscript $SCRIPT

