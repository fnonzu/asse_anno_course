#!/usr/bin/env bash
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=assembly_lja
#SBATCH --output=/data/users/mvolosko/asse_anno_course/logs/output_lja_%j.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/logs/error_lja_%j.e
#SBATCH --partition=pibu_el8
WORKDIR=/data/users/mvolosko/asse_anno_course/data/Sah-0
RESULTDIR=/data/users/mvolosko/asse_anno_course/data/results/assembly_lja

mkdir -p $RESULTDIR

apptainer exec \
--bind $WORKDIR \
/containers/apptainer/lja-0.2.sif \
lja -o $RESULTDIR --reads $WORKDIR/ERR11437328.fastq.gz --diploid

