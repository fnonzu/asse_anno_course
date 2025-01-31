#!/usr/bin/env bash
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=assembly_flye
#SBATCH --output=/data/users/mvolosko/asse_anno_course/logs/output_flye_%j.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/logs/error_flye_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mvolosko/asse_anno_course/data/Sah-0
RESULTDIR=/data/users/mvolosko/asse_anno_course/data/results/assembly_flye

mkdir -p $RESULTDIR

apptainer exec \
--bind $WORKDIR \
/containers/apptainer/flye_2.9.5.sif \
flye --pacbio-raw $WORKDIR/ERR11437328.fastq.gz \
--out-dir $RESULTDIR\