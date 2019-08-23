#!/bin/bash
#SBATCH -J blastp
#SBATCH --output=parse_%j.out
#SBATCH --error=parse_%j.err
#SBATCH -p normal,hns
#SBATCH --time=500
#SBATCH --nodes=1
#SBATCH -c 1
#SBATCH --mem-per-cpu=15G


#!/bin/bash


module load math py-numpy
module load viz py-matplotlib

python creating_timeline.py