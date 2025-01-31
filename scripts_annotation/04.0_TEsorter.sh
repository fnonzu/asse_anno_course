#!/usr/bin/env bash
#SBATCH --time=1:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=aannotations
#SBATCH --output=/data/users/mvolosko/asse_anno_course/annotations/logs/output_tesorter_%j.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/annotations/logs/error_tesorter_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mvolosko/asse_anno_course/annotations/output/EDTA_annotation/
cd $WORKDIR
module load SeqKit/2.6.1
# Extract Copia sequences
#seqkit grep -r -p "Copia" $WORKDIR/assembly.fasta.mod.EDTA.TElib.fa > Copia_sequences.fa
# Extract Gypsy sequences
#seqkit grep -r -p "Gypsy" $WORKDIR/assembly.fasta.mod.EDTA.TElib.fa > Gypsy_sequences.fa

# Step 2


apptainer exec \
  -C -H $WORKDIR -H $PWD:/work \
  --writable-tmpfs /data/courses/assembly-annotation-course/CDS_annotation/containers/TEsorter_1.3.0.sif \
  TEsorter Copia_sequences.fa -db rexdb-plant

apptainer exec \
  -C -H $WORKDIR -H $PWD:/work \
  --writable-tmpfs /data/courses/assembly-annotation-course/CDS_annotation/containers/TEsorter_1.3.0.sif \
  TEsorter Gypsy_sequences.fa -db rexdb-plant
