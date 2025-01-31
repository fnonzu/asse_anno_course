#!/usr/bin/env bash
#SBATCH --time=12:00:00
#SBATCH --mem=400G
#SBATCH --cpus-per-task=32
#SBATCH --job-name=annotations
#SBATCH --output=/data/users/mvolosko/asse_anno_course/annotations/logs/output_edta_%j.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/annotations/logs/error_edta_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mvolosko/asse_anno_course/data/results/assembly_flye
RESULTDIR=/data/users/mvolosko/asse_anno_course/annotations/output/EDTA_annotation

mkdir -p $RESULTDIR

cd $RESULTDIR

apptainer exec \
 -C -H $WORKDIR -H ${pwd}:/work \
 --writable-tmpfs -u /data/users/tschiller/annotation_course/edta_2.2.0--hdfd78af_1.sif \
 EDTA.pl \
 --genome $WORKDIR/assembly.fasta \
 --species others \
 --step all \
 --cds "/data/courses/assembly-annotation-course/CDS_annotation/data/TAIR10_cds_20110103_representative_gene_model_updated" \
 --anno 1 \
 --threads 20 \
 --overwrite 1 \
 --force 1 
