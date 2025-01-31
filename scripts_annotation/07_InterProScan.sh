#!/usr/bin/env bash

#SBATCH --cpus-per-task=40
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=InterProScan
#SBATCH --output=/data/users/mvolosko/asse_anno_course/annotations/logs/%j_output_InterProScan.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/annotations/logs/%j_error_InterProScan.e
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/mvolosko/asse_anno_course/annotations/output/final"
COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
protein="assembly.all.maker.proteins.fasta"

cd $WORKDIR

apptainer exec \
 --bind $COURSEDIR/data/interproscan-5.70-102.0/data:/opt/interproscan/data \
 --bind $WORKDIR \
 --bind $COURSEDIR \
 --bind $SCRATCH:/temp \
 $COURSEDIR/containers/interproscan_latest.sif \
 /opt/interproscan/interproscan.sh \
 -appl pfam --disable-precalc -f TSV \
 --goterms --iprlookup --seqtype p \
 -i ${protein}.renamed.fasta -o output.iprscan