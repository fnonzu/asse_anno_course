#!/usr/bin/env bash

#SBATCH --time=04:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=nucmer_mummerplot
#SBATCH --output=/data/users/mvolosko/asse_anno_course/logs/output_nucmer_mummerplot_%j.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/logs/error_nucmer_mummerplot_%j.e
#SBATCH --partition=pibu_el8

REFERENCE=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
FLYE_ASSEMBLY_Sah0=/data/users/mvolosko/asse_anno_course/data/results/assembly_flye/assembly.fasta
FLYE_ASSEMBLY_Lu1=/data/users/amaalouf/transcriptome_assembly/assemblies/flye_assembly/assembly.fasta
FLYE_ASSEMBLY_hiroshima=/data/users/fgribi/genome_assembly/assembly/primary_assemblies/assembly.flye.fasta
RESULT_DIR=/data/users/mvolosko/asse_anno_course/data/results/nucmer_mummerplot
CONTAINER_PATH=/containers/apptainer/mummer4_gnuplot.sif

mkdir -p $RESULT_DIR

# Run comparisons between assemblies
echo "Running nucmer and mummerplot for inter-assembly comparisons..."

apptainer exec $CONTAINER_PATH \
nucmer --prefix=$RESULT_DIR/Sah0_Lu1 --breaklen 1000 --mincluster 1000 $FLYE_ASSEMBLY_Sah0 $FLYE_ASSEMBLY_Lu1

apptainer exec $CONTAINER_PATH \
mummerplot -R $FLYE_ASSEMBLY_Sah0 -Q $FLYE_ASSEMBLY_Lu1 -layout -t png \
--prefix $RESULT_DIR/Sah0_Lu1 $RESULT_DIR/Sah0_Lu1.delta


apptainer exec $CONTAINER_PATH \
nucmer --prefix=$RESULT_DIR/Sah0_hiroshima --breaklen 1000 --mincluster 1000 $FLYE_ASSEMBLY_Sah0 $FLYE_ASSEMBLY_hiroshima

apptainer exec $CONTAINER_PATH \
mummerplot -R $FLYE_ASSEMBLY_Sah0 -Q $FLYE_ASSEMBLY_hiroshima -layout -t png \
--prefix $RESULT_DIR/Sah0_hiroshima $RESULT_DIR/Sah0_hiroshima.delta


echo "All nucmer and mummerplot tasks completed."
