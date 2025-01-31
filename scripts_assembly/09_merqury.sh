#!/usr/bin/env bash

#SBATCH --time=1-00:00:00
#SBATCH --mem=90G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=merqury_all
#SBATCH --output=/data/users/mvolosko/asse_anno_course/logs/output_merqury_%j.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/logs/error_merqury_%j.e
#SBATCH --partition=pibu_el8

container_path="/containers/apptainer/merqury_1.3.sif"

export MERQURY="/usr/local/share/merqury"

READS=/data/users/mvolosko/asse_anno_course/data/Sah-0/*gz
KMER_SIZE=18 ## mind change
# genome: 130000000
# tolerable collision rate: 0.001
# 18.4591
MERYL_DB_DIR=/data/users/mvolosko/asse_anno_course/data/meryl_db

FLYE_ASSEMBLY=/data/users/mvolosko/asse_anno_course/data/results/assembly_flye/assembly_flye.fasta
HIFIASM_ASSEMBLY=/data/users/mvolosko/asse_anno_course/data/results/assembly_hifiasm/assembly_hifiasm.fasta
LJA_ASSEMBLY=/data/users/mvolosko/asse_anno_course/data/results/assembly_lja/assembly_lja.fasta

FLYE_RESULT_DIR=/data/users/mvolosko/asse_anno_course/data/results/merqury_flye
HIFIASM_RESULT_DIR=/data/users/mvolosko/asse_anno_course/data/results/merqury_hifiasm
LJA_RESULT_DIR=/data/users/mvolosko/asse_anno_course/data/results/merqury_lja


# Prepare meryl k-mer database
#echo "Creating meryl k-mer database from reads..."
#mkdir -p $MERYL_DB_DIR
#apptainer exec $container_path \
#meryl count k=$KMER_SIZE output $MERYL_DB_DIR/meryl_db.meryl $READS

echo "Running Merqury for Flye assembly..."
#rm -rf $FLYE_RESULT_DIR
mkdir -p $FLYE_RESULT_DIR
apptainer exec \
--bind /data \
$container_path \
merqury.sh $MERYL_DB_DIR/meryl_db.meryl $FLYE_ASSEMBLY eval_flye || true

echo "Running Merqury for Hifiasm assembly..."
#rm -rf $HIFIASM_RESULT_DIR
mkdir -p $HIFIASM_RESULT_DIR
apptainer exec \
--bind /data \
$container_path \
$MERQURY/merqury.sh $MERYL_DB_DIR/meryl_db.meryl $HIFIASM_ASSEMBLY eval_hifiasm || true

echo "Running Merqury for LJA assembly..."
#rm -rf $LJA_RESULT_DIR
mkdir -p $LJA_RESULT_DIR
apptainer exec \
--bind /data \
$container_path \
$MERQURY/merqury.sh $MERYL_DB_DIR/meryl_db.meryl $LJA_ASSEMBLY eval_lja || true

echo "Merqury evaluations completed."
