#!/bin/bash
#SBATCH --output=parsing_%j.out
#SBATCH --error=parsing_%j.err
#SBATCH -p normal,hns
#SBATCH --time=350
#SBATCH --nodes=1
#SBATCH -c 5

#!/bin/bash

cd /scratch/groups/khosla/Orphan_PKS/26FebParseBlastP/scripts/


perl corrected_parse_blastp.pl /scratch/groups/khosla/Orphan_PKS/New_approach/blastp_scores /scratch/groups/khosla/Orphan_PKS/antismash_from_fasta/clusterTableNRNS/clusterTableNonRedundantNonSimilar.6dbs.prot_len.txt  /scratch/groups/khosla/Orphan_PKS/New_approach/parsed_blastp_scores/parsed_scores 5250 5500 &

perl corrected_parse_blastp.pl /scratch/groups/khosla/Orphan_PKS/New_approach/blastp_scores /scratch/groups/khosla/Orphan_PKS/antismash_from_fasta/clusterTableNRNS/clusterTableNonRedundantNonSimilar.6dbs.prot_len.txt  /scratch/groups/khosla/Orphan_PKS/New_approach/parsed_blastp_scores/parsed_scores 5500 5750 &

perl corrected_parse_blastp.pl /scratch/groups/khosla/Orphan_PKS/New_approach/blastp_scores /scratch/groups/khosla/Orphan_PKS/antismash_from_fasta/clusterTableNRNS/clusterTableNonRedundantNonSimilar.6dbs.prot_len.txt  /scratch/groups/khosla/Orphan_PKS/New_approach/parsed_blastp_scores/parsed_scores 5750 6000 &

perl corrected_parse_blastp.pl /scratch/groups/khosla/Orphan_PKS/New_approach/blastp_scores /scratch/groups/khosla/Orphan_PKS/antismash_from_fasta/clusterTableNRNS/clusterTableNonRedundantNonSimilar.6dbs.prot_len.txt  /scratch/groups/khosla/Orphan_PKS/New_approach/parsed_blastp_scores/parsed_scores 6000 6250 &

perl corrected_parse_blastp.pl /scratch/groups/khosla/Orphan_PKS/New_approach/blastp_scores /scratch/groups/khosla/Orphan_PKS/antismash_from_fasta/clusterTableNRNS/clusterTableNonRedundantNonSimilar.6dbs.prot_len.txt  /scratch/groups/khosla/Orphan_PKS/New_approach/parsed_blastp_scores/parsed_scores 6250 6500 &

wait

exit 0