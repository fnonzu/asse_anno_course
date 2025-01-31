#!/usr/bin/env bash

#SBATCH --partition=pibu_el8
#SBATCH --job-name=omark
#SBATCH --time=10:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --output=/data/users/mvolosko/asse_anno_course/annotations/logs/%j_output_omark_prep.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/annotations/logs/%j_error_omark_prep.e

module load tabix/0.2.6-GCCcore-10.3.0

WORKDIR=/data/users/mvolosko/asse_anno_course/annotations/output/final/prepare_Jbrowse
mkdir -p $WORKDIR
cd $WORKDIR

# Sort GFF files (if not already sorted):
sort -k1,1 -k4,4n /data/users/mvolosko/asse_anno_course/annotations/output/annotations_maker/assembly.all.maker.gff > original_models.sorted.gff
sort -k1,1 -k4,4n /data/users/mvolosko/asse_anno_course/annotations/output/final/miniprot/miniprot_out.gff > miniprot_out.sorted.gff

# Compress and index with Tabix:
bgzip original_models.sorted.gff
tabix -p gff original_models.sorted.gff.gz

bgzip miniprot_out.sorted.gff
tabix -p gff miniprot_out.sorted.gff.gz

# Example: Create a BED file for fragment_HOGs (customize as needed):
grep '>' /data/users/mvolosko/asse_anno_course/annotations/output/final/fragment_HOGs | awk -F'[:>-]' '{print $2 "\t" $3 "\t" $4 "\t" $1}' > fragment_HOGs.bed
