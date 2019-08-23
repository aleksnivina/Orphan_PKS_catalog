#!/bin/bash
#SBATCH --output=matrix_%j.out
#SBATCH --error=matrix_%j.err
#SBATCH -p normal,hns
#SBATCH --time=500
#SBATCH --nodes=1
#SBATCH -c 1
#SBATCH --mem-per-cpu=20G

#!/bin/bash

cd /scratch/groups/khosla/Orphan_PKS/2MarDistanceMatrix/

perl pairsToMatrix_blastp.pl ../New_approach/parsed_scores.all_final ../antismash_from_fasta/clusterTableNRNS/clusterTableNonRedundantNonSimilar.6dbs.prot_len.correct_domains.txt > ../New_approach/dataMatrix_blastp.txt