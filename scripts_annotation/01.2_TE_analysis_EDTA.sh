#!/usr/bin/env bash
#SBATCH --time=2:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=aannotations
#SBATCH --output=/data/users/mvolosko/asse_anno_course/annotations/logs/output_analysedta_%j.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/annotations/logs/error_analysedta_%j.e
#SBATCH --partition=pibu_el8

module load BEDTools/2.30.0-GCC-10.3.0

INPUT_GFF=/data/users/mvolosko/asse_anno_course/annotations/output/EDTA_annotation/assembly.fasta.mod.EDTA.anno/assembly.fasta.mod.EDTA.TEanno.gff3
GENOME=/data/users/mvolosko/asse_anno_course/data/results/assembly_flye/assembly.fasta.fai
WORKDIR=/data/users/mvolosko/asse_anno_course/annotations/output/TE_results
cd $WORKDIR

# 1. Extract and count TE classifications robustly
grep -v '^#' "$INPUT_GFF" | \
  awk -F'\t' '$3 ~ /_retrotransposon|_transposon|repeat_region/ {print $9}' | \
  grep -o 'Classification=[^;]*' | \
  sed 's/Classification=//' | \
  sort | uniq -c | sort -nr

# 2. Generate genome sizes
cut -f1,2 "$GENOME" > genome.sizes

# 3. Calculate TE coverage per chromosome
bedtools genomecov -i "$INPUT_GFF" -g genome.sizes -d | \
  awk '{print $1"\t"$2"\t"$3}' > TE_coverage_per_bp.txt

# 4. Total number of TEs
grep -c -E '_retrotransposon|_transposon|repeat_region' "$INPUT_GFF"

# 5. TE length distribution
grep -v '^#' "$INPUT_GFF" | \
  awk -F'\t' '$3 ~ /_retrotransposon|_transposon|repeat_region/ {print $5 - $4 + 1}' | \
  datamash mean 1 median 1 max 1
