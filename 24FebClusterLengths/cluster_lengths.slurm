#!/bin/bash
#SBATCH --output=calculate_len.%j.out
#SBATCH --error=calculate_len.%j.err
#SBATCH -p normal,hns
#SBATCH --time=1000
#SBATCH --nodes=1
#SBATCH -c 1
#SBATCH --mem-per-cpu=10G



#!/bin/bash

module load python
module load biology py-biopython
module load math py-scipystack

python ./cluster_lengths.py  -cluster_file /scratch/groups/khosla/Orphan_PKS/antismash_from_fasta/clusterTableNRNS/clusterTableNonRedundantNonSimilar.6dbs.txt -inputf /scratch/groups/khosla/Orphan_PKS/New_approach/prot_fasta_withClusterN_for_blastp/ -output_cluster_file /scratch/groups/khosla/Orphan_PKS/antismash_from_fasta/clusterTableNRNS/clusterTableNonRedundantNonSimilar.6dbs.prot_len.txt
