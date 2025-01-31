#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=40G
#SBATCH --cpus-per-task=1
#SBATCH --job-name=fastp
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/mvolosko/asse_anno_course/logs/output_fastp_%j.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/logs/error_fastp_%j.e
#SBATCH --mail-user=myroslava.volosko@students.unibe.ch
#SBATCH --mail-type=end

# Define directories
WORKDIR=/data/users/mvolosko/asse_anno_course/data/RNAseq_Sha
OUTDIR=/data/users/mvolosko/asse_anno_course/data/results/trim_results
REPORTDIR=$OUTDIR/report

# Load module
module load fastp/0.23.4-GCC-10.3.0

# Create output directories if they don't exist
mkdir -p $OUTDIR
mkdir -p $REPORTDIR

# Move to the working directory
cd $WORKDIR

# Define input and output files (paired end)
INPUT_R1="ERR754081_1.fastq.gz"
INPUT_R2="ERR754081_2.fastq.gz"
OUTPUT_R1="$OUTDIR/ERR754081_1.R1.fastq.gz"
OUTPUT_R2="$OUTDIR/ERR754081_2.R2.fastq.gz"
REPORT="$REPORTDIR/fastp_rnaseq_report.html"

# Run fastp for paired-end reads
fastp -i $INPUT_R1 -I $INPUT_R2 -o $OUTPUT_R1 -O $OUTPUT_R2 -h $REPORT
