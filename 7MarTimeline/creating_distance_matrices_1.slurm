#!/bin/bash
#SBATCH --output=matrix_%j.out
#SBATCH --error=matrix_%j.err
#SBATCH -p normal,hns
#SBATCH --time=500
#SBATCH --nodes=1
#SBATCH -c 5

#!/bin/bash

cd /scratch/groups/khosla/Orphan_PKS/7MarTimeline

perl creating_distance_matrices_by_year.pl /scratch/groups/khosla/Orphan_PKS/New_approach/parsed_scores.all_final ./ClusterTables/clusterTable1994.nonidentical.txt ./DistanceMatrices/distanceMatrix1994.txt &

perl creating_distance_matrices_by_year.pl /scratch/groups/khosla/Orphan_PKS/New_approach/parsed_scores.all_final ./ClusterTables/clusterTable1995.nonidentical.txt ./DistanceMatrices/distanceMatrix1995.txt &

perl creating_distance_matrices_by_year.pl /scratch/groups/khosla/Orphan_PKS/New_approach/parsed_scores.all_final ./ClusterTables/clusterTable1996.nonidentical.txt ./DistanceMatrices/distanceMatrix1996.txt &

perl creating_distance_matrices_by_year.pl /scratch/groups/khosla/Orphan_PKS/New_approach/parsed_scores.all_final ./ClusterTables/clusterTable1997.nonidentical.txt ./DistanceMatrices/distanceMatrix1997.txt &

perl creating_distance_matrices_by_year.pl /scratch/groups/khosla/Orphan_PKS/New_approach/parsed_scores.all_final ./ClusterTables/clusterTable1998.nonidentical.txt ./DistanceMatrices/distanceMatrix1998.txt &

wait

exit 0