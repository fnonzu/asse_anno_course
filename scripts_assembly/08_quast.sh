#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=128G
#SBATCH --cpus-per-task=32
#SBATCH --job-name=quast_all
#SBATCH --output=/data/users/mvolosko/asse_anno_course/logs/output_quast_all_%j.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/logs/error_quast_all_%j.e
#SBATCH --partition=pibu_el8

# Set directories
FLYE_WORKDIR=/data/users/mvolosko/asse_anno_course/data/results/assembly_flye
HIFIASM_WORKDIR=/data/users/mvolosko/asse_anno_course/data/results/assembly_hifiasm
LJA_WORKDIR=/data/users/mvolosko/asse_anno_course/data/results/assembly_lja
RESULTDIR=/data/users/mvolosko/asse_anno_course/data/results/quast_all_features
REFERENCE=/data/courses/assembly-annotation-course/references

# Create result directory
mkdir -p $RESULTDIR

# Run Quast with multiple assemblies
apptainer exec \
--bind $FLYE_WORKDIR \
--bind $HIFIASM_WORKDIR \
--bind $LJA_WORKDIR \
/containers/apptainer/quast_5.2.0.sif \
python /usr/local/bin/quast \
-o $RESULTDIR \
-r $REFERENCE/*.fa \
--eukaryote \
--features $REFERENCE/*.gff3 \
-l FLYE,HIFIASM,LJA \
$FLYE_WORKDIR/*.fasta \
$HIFIASM_WORKDIR/*.fa \
$LJA_WORKDIR/*.fasta
