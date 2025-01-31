#!/usr/bin/env bash

#SBATCH --cpus-per-task=5
#SBATCH --mem=64G
#SBATCH --time=1:00:00
#SBATCH --job-name=longestfilter
#SBATCH --output=/data/users/mvolosko/asse_anno_course/annotations/logs/%j_output_longestfilter.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/annotations/logs/%j_error_longestfilter.e
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/mvolosko/asse_anno_course/annotations/output/final"
cd $WORKDIR


module load SeqKit/2.6.1

seqkit fx2tab -l -n -i /data/users/mvolosko/asse_anno_course/annotations/output/final/assembly.all.maker.transcripts.fasta.renamed.filtered.fasta | sort -k2,2nr | awk '!seen[$1]++ {print $1}' > longtrans.txt
seqkit fx2tab -l -n -i /data/users/mvolosko/asse_anno_course/annotations/output/final/assembly.all.maker.proteins.fasta.renamed.filtered.fasta | sort -k2,2nr | awk '!seen[$1]++ {print $1}' > longproteins.txt

seqkit grep -f longtrans.txt /data/users/mvolosko/asse_anno_course/annotations/output/final/assembly.all.maker.transcripts.fasta.renamed.filtered.fasta -o transcripts.longest.fasta

seqkit grep -f longproteins.txt /data/users/mvolosko/asse_anno_course/annotations/output/final/assembly.all.maker.proteins.fasta.renamed.filtered.fasta -o proteins.longest.fasta