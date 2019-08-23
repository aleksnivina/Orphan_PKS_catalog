#!/bin/bash
#SBATCH --output=matrix_%j.out
#SBATCH --error=matrix_%j.err
#SBATCH -p normal,hns
#SBATCH --time=1000
#SBATCH --nodes=1
#SBATCH -c 5

#!/bin/bash

cd /scratch/groups/khosla/Orphan_PKS/7MarTimeline

perl creating_distance_matrices_by_year.pl /scratch/groups/khosla/Orphan_PKS/New_approach/parsed_scores.all_final ./ClusterTables/clusterTable2014.nonidentical.txt ./DistanceMatrices/distanceMatrix2014.txt &

perl creating_distance_matrices_by_year.pl /scratch/groups/khosla/Orphan_PKS/New_approach/parsed_scores.all_final ./ClusterTables/clusterTable2015.nonidentical.txt ./DistanceMatrices/distanceMatrix2015.txt &

perl creating_distance_matrices_by_year.pl /scratch/groups/khosla/Orphan_PKS/New_approach/parsed_scores.all_final ./ClusterTables/clusterTable2016.nonidentical.txt ./DistanceMatrices/distanceMatrix2016.txt &

perl creating_distance_matrices_by_year.pl /scratch/groups/khosla/Orphan_PKS/New_approach/parsed_scores.all_final ./ClusterTables/clusterTable2017.nonidentical.txt ./DistanceMatrices/distanceMatrix2017.txt &

perl creating_distance_matrices_by_year.pl /scratch/groups/khosla/Orphan_PKS/New_approach/parsed_scores.all_final ./ClusterTables/clusterTable2018.nonidentical.txt ./DistanceMatrices/distanceMatrix2018.txt &

wait

exit 0