#!/bin/bash
#SBATCH --output=chain_%j.out
#SBATCH --error=chain_%j.err
#SBATCH -p normal,hns
#SBATCH --time=150
#SBATCH --nodes=1
#SBATCH -c 5

#!/bin/bash

cd /scratch/groups/khosla/Orphan_PKS/7MarTimeline

perl chaining_blastp.pl ./ParsedScores/parsed_scores.2014 0.9  &

perl chaining_blastp.pl ./ParsedScores/parsed_scores.2015 0.9  &

perl chaining_blastp.pl ./ParsedScores/parsed_scores.2016 0.9  &

perl chaining_blastp.pl ./ParsedScores/parsed_scores.2017 0.9  &

perl chaining_blastp.pl ./ParsedScores/parsed_scores.2018 0.9  &

wait

exit 0