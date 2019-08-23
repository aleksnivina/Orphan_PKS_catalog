#!/bin/bash
#SBATCH --output=parsing_%j.out
#SBATCH --error=parsing_%j.err
#SBATCH -p normal,hns
#SBATCH --time=350
#SBATCH --nodes=1
#SBATCH -c 5

#!/bin/bash

cd /scratch/groups/khosla/Orphan_PKS/26FebParseBlastP/scripts/

perl corrected_parse_blastp.pl /scratch/groups/khosla/Orphan_PKS/New_approach/blastp_scores /scratch/groups/khosla/Orphan_PKS/antismash_from_fasta/clusterTableNRNS/clusterTableNonRedundantNonSimilar.6dbs.prot_len.txt  /scratch/groups/khosla/Orphan_PKS/New_approach/parsed_blastp_scores/parsed_scores 2750 3000 &

perl corrected_parse_blastp.pl /scratch/groups/khosla/Orphan_PKS/New_approach/blastp_scores /scratch/groups/khosla/Orphan_PKS/antismash_from_fasta/clusterTableNRNS/clusterTableNonRedundantNonSimilar.6dbs.prot_len.txt  /scratch/groups/khosla/Orphan_PKS/New_approach/parsed_blastp_scores/parsed_scores 3000 3250 &

perl corrected_parse_blastp.pl /scratch/groups/khosla/Orphan_PKS/New_approach/blastp_scores /scratch/groups/khosla/Orphan_PKS/antismash_from_fasta/clusterTableNRNS/clusterTableNonRedundantNonSimilar.6dbs.prot_len.txt  /scratch/groups/khosla/Orphan_PKS/New_approach/parsed_blastp_scores/parsed_scores 3250 3500 &

perl corrected_parse_blastp.pl /scratch/groups/khosla/Orphan_PKS/New_approach/blastp_scores /scratch/groups/khosla/Orphan_PKS/antismash_from_fasta/clusterTableNRNS/clusterTableNonRedundantNonSimilar.6dbs.prot_len.txt  /scratch/groups/khosla/Orphan_PKS/New_approach/parsed_blastp_scores/parsed_scores 3500 3750 &

perl corrected_parse_blastp.pl /scratch/groups/khosla/Orphan_PKS/New_approach/blastp_scores /scratch/groups/khosla/Orphan_PKS/antismash_from_fasta/clusterTableNRNS/clusterTableNonRedundantNonSimilar.6dbs.prot_len.txt  /scratch/groups/khosla/Orphan_PKS/New_approach/parsed_blastp_scores/parsed_scores 3750 4000 &



wait

exit 0