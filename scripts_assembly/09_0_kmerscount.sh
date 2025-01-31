#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=merqury_kmercount
#SBATCH --output=/data/users/mvolosko/asse_anno_course/logs/output_kmercount_%j.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/logs/error_kmercount_%j.e
#SBATCH --partition=pibu_el8

export MERQURY="/usr/local/share/merqury"

apptainer exec --bind /data /containers/apptainer/merqury_1.3.sif \
$MERQURY/best_k.sh 130000000 
