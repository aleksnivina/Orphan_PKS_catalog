#!/bin/bash
#SBATCH -J blastp
#SBATCH --output=blastp_%A_%a.out
#SBATCH --error=blastp_%A_%a.err
#SBATCH -p normal,hns
#SBATCH --time=500
#SBATCH --nodes=1
#SBATCH -c 1
#SBATCH --mem=15G

#!/bin/bash


cd /scratch/groups/khosla/Orphan_PKS/New_approach/prot_fasta_withClusterN_for_blastp

module load biology
module load ncbi-blast+/

FILES=(*.fasta)
FILENAME=${FILES[${SLURM_ARRAY_TASK_ID}]}


blastp -db /scratch/groups/khosla/Orphan_PKS/New_approach/all_prot_withClusterN_blast_db -query /scratch/groups/khosla/Orphan_PKS/New_approach/prot_fasta_withClusterN_for_blastp/${FILENAME} -outfmt 7 -num_threads 1 -out /scratch/groups/khosla/Orphan_PKS/New_approach/blastp_scores/${FILENAME}.blastp.out -max_target_seqs 10000