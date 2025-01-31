#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --time=1:00:00
#SBATCH --job-name=PFNMAKER
#SBATCH --output=/data/users/mvolosko/asse_anno_course/annotations/logs/%j_output_uniprot.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/annotations/logs/%j_error_uniprot.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mvolosko/asse_anno_course/annotations/output/final
cd $WORKDIR

total_proteins=$(grep -c ">" maker_proteins.fasta.Uniprot)
proteins_with_hits=$(cut -f1 blastp.txt | sort | uniq | wc -l)
echo "Percentage with homology: $(($proteins_with_hits * 100 / $total_proteins))%"

# # Get IDs of proteins without UniProt hits
# grep ">" maker_proteins.fasta.Uniprot | cut -d ' ' -f1 | tr -d '>' > all_proteins.txt
# cut -f1 blastp.txt | sort | uniq > proteins_with_hits.txt
# comm -23 all_proteins.txt proteins_with_hits.txt > no_hit_proteins.txt

# # Extract AED scores for these proteins from the GFF3 file
# while read id; do
#   grep "$id" filtered.maker.gff3.Uniprot | grep "AED=" | awk -F "AED=" '{print $2}' | cut -d ';' -f1
# done < no_hit_proteins.txt > no_hit_aeds.txt

# # Calculate the average AED of non-homologous proteins
# awk '{sum+=$1} END {print sum/NR}' no_hit_aeds.txt