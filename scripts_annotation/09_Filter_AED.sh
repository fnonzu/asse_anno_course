#!/usr/bin/env bash

#SBATCH --cpus-per-task=30
#SBATCH --mem=64G
#SBATCH --time=02:00:00
#SBATCH --job-name=AEDFilter
#SBATCH --output=/data/users/mvolosko/asse_anno_course/annotations/logs/%j_output_AEDFilter.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/annotations/logs/%j_error_AEDFilter.e
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/mvolosko/asse_anno_course/annotations/output/final"
cd $WORKDIR
COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
MAKERBIN="$COURSEDIR/softwares/Maker_v3.01.03/src/bin"
gff=/data/users/mvolosko/asse_anno_course/annotations/output/final/assembly.all.maker.noseq.gff
protein=assembly.all.maker.proteins.fasta
transcript=assembly.all.maker.transcripts.fasta


module load UCSC-Utils/448-foss-2021a
module load BioPerl/1.7.8-GCCcore-10.3.0
module load MariaDB/10.6.4-GCC-10.3.0

perl $MAKERBIN/quality_filter.pl -a 0.5 ${gff}.renamed.iprscan.gff > ${gff}_iprscan_quality_filtered.gff

# We only want to keep gene features in the third column of the gff file
grep -P "\tgene\t|\tCDS\t|\texon\t|\tfive_prime_UTR\t|\tthree_prime_UTR\t|\tmRNA\t" ${gff}_iprscan_quality_filtered.gff > filtered.genes.renamed.gff3
cut -f3 filtered.genes.renamed.gff3 | sort | uniq

# We need to add back the gff3 header to the filtered gff file so that it can be used by other tools
grep "^#" ${gff}_iprscan_quality_filtered.gff > header.txt
cat header.txt filtered.genes.renamed.gff3 > filtered.genes.renamed.final.gff3


# Get the names of remaining mRNAs and extract them from the transcript and and their proteins from the protein files
grep -P "\tmRNA\t" filtered.genes.renamed.final.gff3 | awk '{print $9}' | cut -d ';' -f1 | sed 's/ID=//g' >mRNA_list.txt
faSomeRecords ${transcript}.renamed.fasta mRNA_list.txt ${transcript}.renamed.filtered.fasta
faSomeRecords ${protein}.renamed.fasta mRNA_list.txt ${protein}.renamed.filtered.fasta