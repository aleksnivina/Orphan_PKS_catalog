#!/bin/bash
#SBATCH --job-name=local_copy
#SBATCH --ntasks=1
#SBATCH --output=lcJob.out
#SBATCH --error=lcJob.err
#SBATCH --cpus-per-task=4
#SBATCH --mem=256G
#SBATCH --time=1-00:00:00
#SBATCH -p bigmem
#SBATCH --mail-user=nivina@stanford.edu
#SBATCH --mail-type=ALL

module reset
module load devel math system

#either one here should be good, modify the src and dest to your environment
#rsync -avzh src/ dest/
cp -r /scratch/groups/khosla/Orphan_PKS/antismash_from_fasta/6dbs_prescreen /home/groups/khosla/Orphan_PKS/