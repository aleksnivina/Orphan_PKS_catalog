#!/bin/bash
#SBATCH --output=extract_prot_fasta.%j.out
#SBATCH --error=extract_prot_fasta.%j.err
#SBATCH -p normal,hns
#SBATCH --time=100
#SBATCH --nodes=1
#SBATCH -c 7

#!/bin/bash

module load python
module load biology py-biopython
module load math py-scipystack

python ./extracting_protein_seq.py  -cluster_file /scratch/groups/khosla/Orphan_PKS/antismash_from_fasta/clusterTableNRNS/clusterTableNonRedundantNonSimilar.6dbs.txt -startID 0 -endID 1000 -inputf /scratch/groups/khosla/Orphan_PKS/antismash_from_fasta/6dbs_prescreen/ -outputf /scratch/groups/khosla/Orphan_PKS/New_approach/prot_fasta_withClusterN_for_blastp/ &

python ./extracting_protein_seq.py  -cluster_file /scratch/groups/khosla/Orphan_PKS/antismash_from_fasta/clusterTableNRNS/clusterTableNonRedundantNonSimilar.6dbs.txt -startID 1000 -endID 2000 -inputf /scratch/groups/khosla/Orphan_PKS/antismash_from_fasta/6dbs_prescreen/ -outputf /scratch/groups/khosla/Orphan_PKS/New_approach/prot_fasta_withClusterN_for_blastp/ &

python ./extracting_protein_seq.py  -cluster_file /scratch/groups/khosla/Orphan_PKS/antismash_from_fasta/clusterTableNRNS/clusterTableNonRedundantNonSimilar.6dbs.txt -startID 2000 -endID 3000 -inputf /scratch/groups/khosla/Orphan_PKS/antismash_from_fasta/6dbs_prescreen/ -outputf /scratch/groups/khosla/Orphan_PKS/New_approach/prot_fasta_withClusterN_for_blastp/ &

python ./extracting_protein_seq.py  -cluster_file /scratch/groups/khosla/Orphan_PKS/antismash_from_fasta/clusterTableNRNS/clusterTableNonRedundantNonSimilar.6dbs.txt -startID 3000 -endID 4000 -inputf /scratch/groups/khosla/Orphan_PKS/antismash_from_fasta/6dbs_prescreen/ -outputf /scratch/groups/khosla/Orphan_PKS/New_approach/prot_fasta_withClusterN_for_blastp/ &

python ./extracting_protein_seq.py  -cluster_file /scratch/groups/khosla/Orphan_PKS/antismash_from_fasta/clusterTableNRNS/clusterTableNonRedundantNonSimilar.6dbs.txt -startID 4000 -endID 5000 -inputf /scratch/groups/khosla/Orphan_PKS/antismash_from_fasta/6dbs_prescreen/ -outputf /scratch/groups/khosla/Orphan_PKS/New_approach/prot_fasta_withClusterN_for_blastp/ &

python ./extracting_protein_seq.py  -cluster_file /scratch/groups/khosla/Orphan_PKS/antismash_from_fasta/clusterTableNRNS/clusterTableNonRedundantNonSimilar.6dbs.txt -startID 5000 -endID 6000 -inputf /scratch/groups/khosla/Orphan_PKS/antismash_from_fasta/6dbs_prescreen/ -outputf /scratch/groups/khosla/Orphan_PKS/New_approach/prot_fasta_withClusterN_for_blastp/ &

python ./extracting_protein_seq.py  -cluster_file /scratch/groups/khosla/Orphan_PKS/antismash_from_fasta/clusterTableNRNS/clusterTableNonRedundantNonSimilar.6dbs.txt -startID 6000 -endID end -inputf /scratch/groups/khosla/Orphan_PKS/antismash_from_fasta/6dbs_prescreen/ -outputf /scratch/groups/khosla/Orphan_PKS/New_approach/prot_fasta_withClusterN_for_blastp/ &

wait

exit 0