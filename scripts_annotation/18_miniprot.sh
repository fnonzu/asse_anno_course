#!/usr/bin/env bash

#SBATCH --partition=pibu_el8
#SBATCH --job-name=miniprot
#SBATCH --time=3-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --output=/data/users/mvolosko/asse_anno_course/annotations/logs/%j_output_miniprot.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/annotations/logs/%j_error_miniprot.e

# Load modules or activate environment
eval "$(/home/amaalouf/miniconda3/bin/conda shell.bash hook)"
conda activate OMArk

# Ensure omadb is installed
conda install -y -c bioconda omadb

# Set variables
WORK_DIR=/data/users/mvolosko/asse_anno_course/annotations/output/quality/miniprot
OMARK_OUT=/data/users/mvolosko/asse_anno_course/annotations/output/quality/omark/omark_output
ORIG_FA=/data/users/mvolosko/asse_anno_course/data/results/assembly_flye/assembly.fasta
SEQ_FASTA=/data/users/mvolosko/asse_anno_course/annotations/output/quality/miniprot/missing_HOGs.fa

# Ensure working directory exists
mkdir -p $WORK_DIR
cd $WORK_DIR

# Run contextualization
python /data/courses/assembly-annotation-course/CDS_annotation/softwares/OMArk-0.3.0/utils/omark_contextualize.py fragment \
  -m $OMARK_OUT \
  -f fragment_HOGs

python /data/courses/assembly-annotation-course/CDS_annotation/softwares/OMArk-0.3.0/utils/omark_contextualize.py missing \
  -m $OMARK_OUT \
  -f missing_HOGs

# Ensure miniprot is installed
if ! command -v miniprot &> /dev/null; then
  git clone https://github.com/lh3/miniprot
  cd miniprot && make
  cd ..
fi

# Run Miniprot
./miniprot/miniprot -I --gff --outs=0.95 $ORIG_FA $SEQ_FASTA > MINIPROT_OUTPUT.gff
