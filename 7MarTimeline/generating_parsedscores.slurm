#!/bin/bash
#SBATCH --output=chain_%j.out
#SBATCH --error=chain_%j.err
#SBATCH -p normal,hns
#SBATCH --time=500
#SBATCH --nodes=1
#SBATCH -c 1
#SBATCH --mem-per-cpu=20G


#!/bin/bash

cd /scratch/groups/khosla/Orphan_PKS/7MarTimeline

python generating_parsedscore_by_year.py