#!/usr/bin/env bash


#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=buscolja
#SBATCH --output=/data/users/mvolosko/asse_anno_course/logs/output_buscolja_%j.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/logs/error_buscolja_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mvolosko/asse_anno_course/data/results/assembly_lja
RESULTDIR=/data/users/mvolosko/asse_anno_course/data/results/busco_lja

mkdir -p $RESULTDIR

module load BUSCO/5.4.2-foss-2021a

busco -i $WORKDIR/*.fasta -m genome -l brassicales_odb10 -c 16 \
--out_path $RESULTDIR --out BUSCO_lja -f


