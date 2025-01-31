#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=fastqc_tr
#SBATCH --mail-user=myroslava.volosko@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/mvolosko/asse_anno_course/logs/output_qctr_%j.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/logs/error_qctr_%j.e
#SBATCH --partition=pibu_el8
DATADIR=/data/users/mvolosko/asse_anno_course/data/results/trim_results
RESULTDIR=/data/users/mvolosko/asse_anno_course/data/results/qc_tr

mkdir -p $RESULTDIR
module load FastQC/0.11.9-Java-11
fastqc -o $RESULTDIR $DATADIR/*gz


