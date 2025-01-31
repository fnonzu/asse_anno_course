#!/usr/bin/env bash

#SBATCH --partition=pibu_el8
#SBATCH --job-name=omark
#SBATCH --time=10:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --output=/data/users/mvolosko/asse_anno_course/annotations/logs/%j_output_omark_context.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/annotations/logs/%j_error_omark_context.e

module load SeqKit/2.6.1
eval "$(/home/amaalouf/miniconda3/bin/conda shell.bash hook)"
conda activate OMArk
pip install omadb
python -c "import omadb, gffutils, pyfaidx" 

# Set variables
WORKDIR=/data/users/mvolosko/asse_anno_course/annotations/output/final
cd $WORKDIR
COURSEDIR=/data/courses/assembly-annotation-course/CDS_annotation
CONTEXTUALIZE=/data/courses/assembly-annotation-course/CDS_annotation/softwares/OMArk-0.3.0/utils/omark_contextualize.py
OMAMER_PROT=/data/users/mvolosko/asse_anno_course/annotations/output/quality/omark/proteins.longest.fasta.omamer
OMARK_OUT=/data/users/mvolosko/asse_anno_course/annotations/output/quality/omark/omark_output

# cd $WORKDIR/miniprot
# git clone https://github.com/lh3/miniprot
# cd miniprot
# make


python3 $CONTEXTUALIZE fragment -m $OMAMER_PROT -o $OMARK_OUT -f fragment_HOGs
python3 $CONTEXTUALIZE missing -m $OMAMER_PROT -o $OMARK_OUT -f missing_HOGs

cd $WORKDIR/miniprot

GENOME="/data/users/mvolosko/asse_anno_course/data/results/assembly_flye/assembly.fasta"
SEQ_FASTA="/data/users/mvolosko/asse_anno_course/annotations/output/final/fragment_HOGs"
MINIPROT_OUTPUT="miniprot_out.gff"

$WORKDIR/miniprot/miniprot/miniprot -I --gff --outs=0.95 $GENOME $SEQ_FASTA > $MINIPROT_OUTPUT
