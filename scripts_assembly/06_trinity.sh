#!/usr/bin/env bash
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=assembly_trinity
#SBATCH --output=/data/users/mvolosko/asse_anno_course/logs/output_trinity_%j.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/logs/error_trinity_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mvolosko/asse_anno_course/data/RNAseq_Sha
RESULTDIR=/data/users/mvolosko/asse_anno_course/data/results/assembly_trinity

mkdir -p $RESULTDIR

module load Trinity/2.15.1-foss-2021a

#java -jar $EBROOTPICARD/picard.jar

Trinity --seqType fq \
    --left $WORKDIR/ERR754081_1.fastq.gz \
    --right $WORKDIR/ERR754081_2.fastq.gz \
    --CPU 16 \
    --max_memory 64G \
    --output $RESULTDIR