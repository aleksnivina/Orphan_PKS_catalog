#!/bin/bash
#SBATCH --output=count_domains.%j.out
#SBATCH --error=count_domains.%j.err
#SBATCH -p normal,hns
#SBATCH --time=50
#SBATCH --nodes=1
#SBATCH -c 1

#!/bin/bash

module load python
module load biology py-biopython
module load math py-scipystack

python ./counting_domains.py -cluster_file1 /scratch/groups/khosla/Orphan_PKS/antismash_from_fasta/clusterTableNR/clusterTableNonRedundant.6dbs.txt  -cluster_file2 /scratch/groups/khosla/Orphan_PKS/antismash_from_fasta/clusterTableNRNS/clusterTableNonRedundantNonSimilar.6dbs.prot_len.txt -inputf /home/groups/khosla/Orphan_PKS/6dbs_prescreen/ -outputf /scratch/groups/khosla/Orphan_PKS/New_approach/ClusterTables

