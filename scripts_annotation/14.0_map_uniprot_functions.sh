#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --time=10:00:00
#SBATCH --job-name=PFNMAKER
#SBATCH --output=/data/users/mvolosko/asse_anno_course/annotations/logs/%j_output_PFNMAKER.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/annotations/logs/%j_error_PFNMAKER.e
#SBATCH --partition=pibu_el8


WORKDIR=/data/users/mvolosko/asse_anno_course/annotations/output/final
cd $WORKDIR
COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
MAKERBIN="$COURSEDIR/softwares/Maker_v3.01.03/src/bin"

protein="assembly.all.maker.proteins.fasta.renamed.filtered.fasta"
uniprot="/data/courses/assembly-annotation-course/CDS_annotation/data/uniprot/uniprot_viridiplantae_reviewed.fa"
gff3="filtered.genes.renamed.gff3"
blastp="blastp.txt"

cp $protein maker_proteins.fasta.Uniprot
cp $gff3 filtered.maker.gff3.Uniprot

$MAKERBIN/maker_functional_fasta $uniprot $blastp $protein > maker_proteins.fast.Uniprot
$MAKERBIN/maker_functional_gff $uniprot $blastp $gff3 > filtered.maker.gff3.Uniprot



