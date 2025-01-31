#!/usr/bin/env bash
#SBATCH --time=1:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=aannotations
#SBATCH --output=/data/users/mvolosko/asse_anno_course/annotations/logs/output_maker_%j.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/annotations/logs/error_maker_%j.e
#SBATCH --partition=pibu_el8
WORKDIR=/data/users/mvolosko/asse_anno_course/data/results/assembly_flye
mkdir -p $WORKDIR
cd $WORKDIR

apptainer exec --bind $WORKDIR \
/data/courses/assembly-annotation-course/containers2/MAKER_3.01.03.sif maker -CTL \

