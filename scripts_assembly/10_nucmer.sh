#!/usr/bin/env bash

#SBATCH --time=04:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=nucmer_mummerplot
#SBATCH --output=/data/users/mvolosko/asse_anno_course/logs/output_nucmer_mummerplot_%j.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/logs/error_nucmer_mummerplot_%j.e
#SBATCH --partition=pibu_el8

REFERENCE=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
FLYE_ASSEMBLY=/data/users/mvolosko/asse_anno_course/data/results/assembly_flye/*.fa*
HIFIASM_ASSEMBLY=/data/users/mvolosko/asse_anno_course/data/results/assembly_hifiasm/*.fa*
LJA_ASSEMBLY=/data/users/mvolosko/asse_anno_course/data/results/assembly_lja/*.fa*
RESULT_DIR=/data/users/mvolosko/asse_anno_course/data/results/nucmer_mummerplot
CONTAINER_PATH=/containers/apptainer/mummer4_gnuplot.sif

mkdir -p $RESULT_DIR

# echo "Running nucmer for Flye vs Arabidopsis thaliana reference..."
# apptainer exec --bind /data $CONTAINER_PATH \
# nucmer --prefix=$RESULT_DIR/flye_vs_ref --breaklen 1000 --mincluster 1000 $REFERENCE $FLYE_ASSEMBLY

# echo "Running mummerplot for Flye..."
# apptainer exec $CONTAINER_PATH \
# mummerplot -R $REFERENCE -Q $FLYE_ASSEMBLY --filter --fat --layout -t png --prefix $RESULT_DIR/flye_vs_ref $RESULT_DIR/flye_vs_ref.delta

# echo "Running nucmer for Hifiasm vs Arabidopsis thaliana reference..."
# apptainer exec $CONTAINER_PATH \
# nucmer --prefix=$RESULT_DIR/hifiasm_vs_ref --breaklen 1000 --mincluster 1000 $REFERENCE $HIFIASM_ASSEMBLY

# echo "Running mummerplot for Hifiasm..."
# apptainer exec $CONTAINER_PATH \
# mummerplot -R $REFERENCE -Q $HIFIASM_ASSEMBLY --filter --fat --layout -t png --prefix $RESULT_DIR/hifiasm_vs_ref $RESULT_DIR/hifiasm_vs_ref.delta

# echo "Running nucmer for LJA vs Arabidopsis thaliana reference..."
# apptainer exec $CONTAINER_PATH \
# nucmer --prefix=$RESULT_DIR/lja_vs_ref --breaklen 1000 --mincluster 1000 $REFERENCE $LJA_ASSEMBLY

# echo "Running mummerplot for LJA..."
# apptainer exec $CONTAINER_PATH \
# mummerplot -R $REFERENCE -Q $LJA_ASSEMBLY --filter --fat --layout -t png --prefix $RESULT_DIR/lja_vs_ref $RESULT_DIR/lja_vs_ref.delta

# Run comparisons between assemblies
echo "Running nucmer and mummerplot for inter-assembly comparisons..."

# Flye vs Hifiasm
apptainer exec $CONTAINER_PATH \
nucmer --prefix=$RESULT_DIR/flye_vs_hifiasm --breaklen 1000 --mincluster 1000 $FLYE_ASSEMBLY $HIFIASM_ASSEMBLY 
apptainer exec $CONTAINER_PATH \
mummerplot -R $FLYE_ASSEMBLY -Q $HIFIASM_ASSEMBLY --filter --fat --layout -t png --prefix $RESULT_DIR/flye_vs_hifiasm $RESULT_DIR/flye_vs_hifiasm.delta

# Flye vs LJA
apptainer exec $CONTAINER_PATH \
nucmer --prefix=$RESULT_DIR/flye_vs_lja --breaklen 1000 --mincluster 1000 $FLYE_ASSEMBLY $LJA_ASSEMBLY 
apptainer exec $CONTAINER_PATH \
mummerplot -R $FLYE_ASSEMBLY -Q $LJA_ASSEMBLY --filter --fat --layout -t png --prefix $RESULT_DIR/flye_vs_lja $RESULT_DIR/flye_vs_lja.delta

# Hifiasm vs LJA
apptainer exec $CONTAINER_PATH \
nucmer --prefix=$RESULT_DIR/hifiasm_vs_lja --breaklen 1000 --mincluster 1000 $HIFIASM_ASSEMBLY $LJA_ASSEMBLY 
apptainer exec $CONTAINER_PATH \
mummerplot -R $HIFIASM_ASSEMBLY -Q $LJA_ASSEMBLY --filter --fat --layout -t png --prefix $RESULT_DIR/hifiasm_vs_lja $RESULT_DIR/hifiasm_vs_lja.delta

echo "All nucmer and mummerplot tasks completed."

