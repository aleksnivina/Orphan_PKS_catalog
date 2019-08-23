#!/bin/bash
#SBATCH --output=chain_%j.out
#SBATCH --error=chain_%j.err
#SBATCH -p normal,hns
#SBATCH --time=50
#SBATCH --nodes=1
#SBATCH -c 5

#!/bin/bash

cd /scratch/groups/khosla/Orphan_PKS/7MarTimeline

perl chaining_blastp.pl ./ParsedScores/parsed_scores.2004 0.9  &

perl chaining_blastp.pl ./ParsedScores/parsed_scores.2005 0.9  &

perl chaining_blastp.pl ./ParsedScores/parsed_scores.2006 0.9  &

perl chaining_blastp.pl ./ParsedScores/parsed_scores.2007 0.9  &

perl chaining_blastp.pl ./ParsedScores/parsed_scores.2008 0.9  &

wait

exit 0