#!/usr/bin/env bash

#SBATCH --cpus-per-task=20
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=MAKER_Config
#SBATCH --output=/data/users/mvolosko/asse_anno_course/annotations/logs/%j_output_parseRM.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/annotations/logs/%j_error_parseRM.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mvolosko/asse_anno_course/annotations/output/EDTA_annotation/assembly.fasta.mod.EDTA.anno
cd $WORKDIR

module add BioPerl/1.7.8-GCCcore-10.3.0
perl /data/users/mvolosko/asse_anno_course/annotations/scripts/parseRM.pl -i assembly.fasta.mod.out -l 50,1 -v

