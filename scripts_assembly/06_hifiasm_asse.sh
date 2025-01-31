#!/usr/bin/env bash
#SBATCH --time=1-00:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=16
#SBATCH --job-name=assembly_hifiasm
#SBATCH --output=/data/users/mvolosko/asse_anno_course/logs/output_hifiasm_%j.o
#SBATCH --error=/data/users/mvolosko/asse_anno_course/logs/error_hifiasm_%j.e
#SBATCH --partition=pibu_el8

WORKDIR=/data/users/mvolosko/asse_anno_course/data/Sah-0
RESULTDIR=/data/users/mvolosko/asse_anno_course/data/results/assembly_hifiasm

mkdir -p $RESULTDIR

apptainer exec \
--bind $WORKDIR \
/containers/apptainer/hifiasm_0.19.8.sif \
hifiasm -o $RESULTDIR/ERR11437328.asm -t16 \
$WORKDIR/ERR11437328.fastq.gz \

awk '/^S/{print ">"$2;print $3}' \
$RESULTDIR/ERR11437328.asm.bp.p_ctg.gfa > \
$RESULTDIR/ERR11437328.asm.bp.p_ctg.fa
