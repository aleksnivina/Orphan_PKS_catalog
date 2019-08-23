#!/bin/bash
#SBATCH --output=check_%j.out
#SBATCH --error=check_%j.err
#SBATCH -p normal,hns
#SBATCH --time=500
#SBATCH --nodes=1
#SBATCH -c 1

#!/bin/bash


python checking_for_missing_blastp.py --clusterfile ../antismash_from_fasta/clusterTableNRNS/clusterTableNonRedundantNonSimilar.6dbs.txt --blastp_folder ../New_approach/blastp_scores