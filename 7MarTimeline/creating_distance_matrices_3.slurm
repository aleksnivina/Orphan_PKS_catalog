#!/bin/bash
#SBATCH --output=matrix_%j.out
#SBATCH --error=matrix_%j.err
#SBATCH -p normal,hns
#SBATCH --time=500
#SBATCH --nodes=1
#SBATCH -c 5

#!/bin/bash

cd /scratch/groups/khosla/Orphan_PKS/7MarTimeline

perl creating_distance_matrices_by_year.pl /scratch/groups/khosla/Orphan_PKS/New_approach/parsed_scores.all_final ./ClusterTables/clusterTable2004.nonidentical.txt ./DistanceMatrices/distanceMatrix2004.txt &

perl creating_distance_matrices_by_year.pl /scratch/groups/khosla/Orphan_PKS/New_approach/parsed_scores.all_final ./ClusterTables/clusterTable2005.nonidentical.txt ./DistanceMatrices/distanceMatrix2005.txt &

perl creating_distance_matrices_by_year.pl /scratch/groups/khosla/Orphan_PKS/New_approach/parsed_scores.all_final ./ClusterTables/clusterTable2006.nonidentical.txt ./DistanceMatrices/distanceMatrix2006.txt &

perl creating_distance_matrices_by_year.pl /scratch/groups/khosla/Orphan_PKS/New_approach/parsed_scores.all_final ./ClusterTables/clusterTable2007.nonidentical.txt ./DistanceMatrices/distanceMatrix2007.txt &

perl creating_distance_matrices_by_year.pl /scratch/groups/khosla/Orphan_PKS/New_approach/parsed_scores.all_final ./ClusterTables/clusterTable2008.nonidentical.txt ./DistanceMatrices/distanceMatrix2008.txt &

wait

exit 0