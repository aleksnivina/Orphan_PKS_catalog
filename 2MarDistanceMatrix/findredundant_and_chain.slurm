#!/bin/bash
#SBATCH --output=chain_%j.out
#SBATCH --error=chain_%j.err
#SBATCH -p normal,hns
#SBATCH --time=100
#SBATCH --nodes=1
#SBATCH -c 5
#SBATCH --mem-per-cpu=5G

#!/bin/bash

cd /scratch/groups/khosla/Orphan_PKS/2MarDistanceMatrix/

perl findRedundant_and_chain_blastp.pl ../New_approach/parsed_scores.all_final 0.9