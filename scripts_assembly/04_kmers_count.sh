#!/usr/bin/env bash
#SBATCH --cpus-per-task=1
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=kmerscount
#SBATCH --mail-user=myroslava.volosko@students.unibe.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/mvolosko/asse_anno_course/logs/output_kmers_%j.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/logs/error_kmers_%j.e
#SBATCH --partition=pibu_el8

module load Jellyfish/2.3.0-GCC-10.3.0

DATADIR=/data/users/mvolosko/asse_anno_course/data/Sah-0
RESULTDIR=/data/users/mvolosko/asse_anno_course/data/results/jellyfish_output/

mkdir -p $RESULTDIR

jellyfish count \
-C -m 21 -s 5G -t 4 \
-o $RESULTDIR/kmers.jf \
<(zcat $DATADIR/ERR11437328.fastq.gz)
