#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=fastqc
#SBATCH --mail-user=myroslava.volosko@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/mvolosko/asse_anno_course/logs/output_fastqc_%j.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/logs/error_fastqc_%j.e
#SBATCH --partition=pibu_el8

DATADIR=/data/users/mvolosko/asse_anno_course/data
RESULTDIR=/data/users/mvolosko/asse_anno_course/data/results/qc_results

mkdir -p $RESULTDIR

module load FastQC/0.11.9-Java-11

fastqc -o $RESULTDIR $DATADIR/Sah-0/ERR11437328.fastq.gz

fastqc -o $RESULTDIR $DATADIR/RNAseq_Sha/*gz


