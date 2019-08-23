#!/bin/bash
#SBATCH --output=parsing_%j.out
#SBATCH --error=parsing_%j.err
#SBATCH -p normal,hns
#SBATCH --time=350
#SBATCH --nodes=1
#SBATCH -c 3

#!/bin/bash

cd /scratch/groups/khosla/Orphan_PKS/26FebParseBlastP/scripts/


perl corrected_parse_blastp.pl /scratch/groups/khosla/Orphan_PKS/New_approach/blastp_scores /scratch/groups/khosla/Orphan_PKS/antismash_from_fasta/clusterTableNRNS/clusterTableNonRedundantNonSimilar.6dbs.prot_len.txt  /scratch/groups/khosla/Orphan_PKS/New_approach/parsed_blastp_scores/parsed_scores 6500 6750 &

perl corrected_parse_blastp.pl /scratch/groups/khosla/Orphan_PKS/New_approach/blastp_scores /scratch/groups/khosla/Orphan_PKS/antismash_from_fasta/clusterTableNRNS/clusterTableNonRedundantNonSimilar.6dbs.prot_len.txt  /scratch/groups/khosla/Orphan_PKS/New_approach/parsed_blastp_scores/parsed_scores 6750 6987 &

perl corrected_parse_blastp.pl /scratch/groups/khosla/Orphan_PKS/New_approach/blastp_scores /scratch/groups/khosla/Orphan_PKS/antismash_from_fasta/clusterTableNRNS/clusterTableNonRedundantNonSimilar.6dbs.prot_len.txt  /scratch/groups/khosla/Orphan_PKS/New_approach/parsed_blastp_scores/parsed_scores 2250 2500 &


wait

exit 0