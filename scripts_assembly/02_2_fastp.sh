#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=40G
#SBATCH --cpus-per-task=1
#SBATCH --job-name=fastqc_tr
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/mvolosko/asse_anno_course/logs/output_qctr_%j.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/logs/error_qctr_%j.e
#SBATCH --mail-user=myroslava.volosko@students.unibe.ch
#SBATCH --mail-type=end

# Define directories
WORKDIR=/data/users/mvolosko/asse_anno_course/data/Sah-0
OUTDIR=/data/users/mvolosko/asse_anno_course/data/results/qc_tr

# Load module
module load fastp/0.23.4-GCC-10.3.0

# Create output directory if it doesn't exist
mkdir -p $OUTDIR

# Move to the working directory
cd $WORKDIR

# Run FastQC on trimmed reads
fastp -o $OUTDIR -i $WORKDIR/*gz -h $OUTDIR

