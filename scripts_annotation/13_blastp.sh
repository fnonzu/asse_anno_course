#!/usr/bin/env bash

#SBATCH --cpus-per-task=10
#SBATCH --mem=32G
#SBATCH --time=12:00:00
#SBATCH --job-name=blastP
#SBATCH --output=/data/users/mvolosko/asse_anno_course/annotations/logs/%j_output_blastP.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/annotations/logs/%j_error_blastP.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mvolosko/asse_anno_course/annotations/output/final
cd $WORKDIR
mkdir -p blastp

protein="assembly.all.maker.proteins.fasta.renamed.filtered.fasta"
uniprot="/data/courses/assembly-annotation-course/CDS_annotation/data/uniprot/uniprot_viridiplantae_reviewed.fa"


module load BLAST+/2.15.0-gompi-2021a

blastp -query ${protein} -db /data/courses/assembly-annotation-course/CDS_annotation/data/uniprot/uniprot_viridiplantae_reviewed.fa -num_threads 10 -outfmt 6  -evalue 1e-10 -out blastp.txt

