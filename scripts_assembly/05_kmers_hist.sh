#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=hist_jelly
#SBATCH --mail-user=user@unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/mvolosko/asse_anno_course/logs/output_kmershist_%j.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/logs/error_kmershist_%j.e
#SBATCH --partition=pibu_el8

module load Jellyfish/2.3.0-GCC-10.3.0

DATADIR=/data/users/mvolosko/asse_anno_course/data/results/jellyfish_output/

jellyfish histo -t 4 $DATADIR/kmers.jf > $DATADIR/reads.histo
