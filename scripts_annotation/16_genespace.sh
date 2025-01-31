#!/usr/bin/env bash

#SBATCH --partition=pibu_el8
#SBATCH --job-name=R
#SBATCH --time=10:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --output=/data/users/mvolosko/asse_anno_course/annotations/logs/%j_output_genespaceR.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/annotations/logs/%j_error_genespaceR.e

# Load modules
module load R/4.1.0-foss-2021a
module load UCSC-Utils/448-foss-2021a
module load MariaDB/10.6.4-GCC-10.3.0

# Set variables
WORK_DIR=/data/users/mvolosko/asse_anno_course/annotations/output/quality/genespace2
SCRIPT1=/data/users/mvolosko/asse_anno_course/annotations/scripts/16-create_Genespace_folders.R
SCRIPT2=/data/users/mvolosko/asse_anno_course/annotations/scripts/17-Genespace.R
COURSEDIR=/data/courses/assembly-annotation-course/CDS_annotation
CONTAINER=/data/courses/assembly-annotation-course/CDS_annotation/containers/genespace_latest.sif
PEP=$WORK_DIR/genespace/peptide
BED=$WORK_DIR/genespace/bed

# Create working directory
mkdir -p $WORK_DIR
cd $WORK_DIR

export LC_ALL=C
export LANG=C

# Prepare input files
Rscript $SCRIPT1

# # Add other accessions
# # Andrew Lu_1
cp /data/users/amaalouf/transcriptome_assembly/annotation/output/quality/genespace2/genespace/bed/Lu_1.bed $BED/Lu_1.bed
cp /data/users/amaalouf/transcriptome_assembly/annotation/output/quality/genespace2/genespace/peptide/Lu_1.fa $PEP/Lu_1.fa
# hiroshima
cp /data/users/fgribi/genome_annotation/output/GENESPACE/genespace/bed/hiroshima.bed $BED/hiroshima.bed
cp /data/users/fgribi/genome_annotation/output/GENESPACE/genespace/peptide/hiroshima.fa $PEP/hiroshima.fa
# Rename mine
mv $BED/TAIR10.bed $BED/genome1.bed
mv $PEP/TAIR10.fa $PEP/genome1.fa

# Run GeneSpace
apptainer exec \
    --bind $COURSEDIR \
    --bind $WORK_DIR \
    --bind $SCRATCH:/temp \
    $CONTAINER \
    Rscript $SCRIPT2 "$WORK_DIR/genespace"

