#!/usr/bin/env bash

#SBATCH --cpus-per-task=20
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=faip
#SBATCH --output=/data/users/mvolosko/asse_anno_course/annotations/logs/%j_output_faip_generation.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/annotations/logs/%j_error_faip_generation.e
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/mvolosko/asse_anno_course/annotations/output/final"
cd $WORKDIR
COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
MAKERBIN="$COURSEDIR/softwares/Maker_v3.01.03/src/bin"
gff=/data/users/mvolosko/asse_anno_course/annotations/output/final/assembly.all.maker.noseq.gff
protein=assembly.all.maker.proteins.fasta
transcript=assembly.all.maker.transcripts.fasta

module load SAMtools/1.13-GCC-10.3.0

samtools faidx assembly.all.maker.proteins.fasta.renamed.filtered.fasta


