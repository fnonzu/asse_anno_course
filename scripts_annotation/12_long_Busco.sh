#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --time=12:00:00
#SBATCH --job-name=BUSCO
#SBATCH --output=/data/users/mvolosko/asse_anno_course/annotations/logs/%j_output_BUSCO.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/annotations/logs/%j_error_BUSCO.e
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/mvolosko/asse_anno_course/annotations/output/final"
cd $WORKDIR


module load BUSCO/5.4.2-foss-2021a
busco -i proteins.longest.fasta -l brassicales_odb10 -o busco_output_protein -m proteins --cpu 8
busco -i transcripts.longest.fasta -l brassicales_odb10 -o busco_output_trans -m transcriptome --cpu 8
