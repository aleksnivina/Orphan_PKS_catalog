#!/bin/bash
#SBATCH --output=assemble_%j.out
#SBATCH --error=assemble_%j.err
#SBATCH -p normal,hns
#SBATCH --time=500
#SBATCH --nodes=1
#SBATCH -c 1
#SBATCH --mem-per-cpu=20G

#!/bin/bash

cd /scratch/groups/khosla/Orphan_PKS/2MarDistanceMatrix

python assembling_scores.py --clusterfile ../antismash_from_fasta/clusterTableNRNS/clusterTableNonRedundantNonSimilar.6dbs.txt --scorefile_init ../New_approach/parsed_scores.initial --scorefile_additional ../New_approach/parsed_scores.additional --scorefile_yet_addit ../New_approach/parsed_scores.yet_additional --scorefile_missing ../New_approach/parsed_scores.missing --outfolder ../New_approach/