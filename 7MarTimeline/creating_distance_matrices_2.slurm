#!/bin/bash
#SBATCH --output=matrix_%j.out
#SBATCH --error=matrix_%j.err
#SBATCH -p normal,hns
#SBATCH --time=500
#SBATCH --nodes=1
#SBATCH -c 5

#!/bin/bash

cd /scratch/groups/khosla/Orphan_PKS/7MarTimeline

perl creating_distance_matrices_by_year.pl /scratch/groups/khosla/Orphan_PKS/New_approach/parsed_scores.all_final ./ClusterTables/clusterTable1999.nonidentical.txt ./DistanceMatrices/distanceMatrix1999.txt &

perl creating_distance_matrices_by_year.pl /scratch/groups/khosla/Orphan_PKS/New_approach/parsed_scores.all_final ./ClusterTables/clusterTable2000.nonidentical.txt ./DistanceMatrices/distanceMatrix2000.txt &

perl creating_distance_matrices_by_year.pl /scratch/groups/khosla/Orphan_PKS/New_approach/parsed_scores.all_final ./ClusterTables/clusterTable2001.nonidentical.txt ./DistanceMatrices/distanceMatrix2001.txt &

perl creating_distance_matrices_by_year.pl /scratch/groups/khosla/Orphan_PKS/New_approach/parsed_scores.all_final ./ClusterTables/clusterTable2002.nonidentical.txt ./DistanceMatrices/distanceMatrix2002.txt &

perl creating_distance_matrices_by_year.pl /scratch/groups/khosla/Orphan_PKS/New_approach/parsed_scores.all_final ./ClusterTables/clusterTable2003.nonidentical.txt ./DistanceMatrices/distanceMatrix2003.txt &

wait

exit 0