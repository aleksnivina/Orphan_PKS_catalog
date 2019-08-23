#!/bin/bash
#SBATCH --output=chain_%j.out
#SBATCH --error=chain_%j.err
#SBATCH -p normal,hns
#SBATCH --time=100
#SBATCH --nodes=1
#SBATCH -c 5

#!/bin/bash

cd /scratch/groups/khosla/Orphan_PKS/7MarTimeline

perl chaining_blastp.pl ./ParsedScores/parsed_scores.2009 0.9  &

perl chaining_blastp.pl ./ParsedScores/parsed_scores.2010 0.9  &

perl chaining_blastp.pl ./ParsedScores/parsed_scores.2011 0.9  &

perl chaining_blastp.pl ./ParsedScores/parsed_scores.2012 0.9  &

perl chaining_blastp.pl ./ParsedScores/parsed_scores.2013 0.9  &

wait

exit 0