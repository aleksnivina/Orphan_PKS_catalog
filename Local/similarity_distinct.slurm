#!/bin/bash
#SBATCH --output=distances_%j.out
#SBATCH --error=distances_%j.err
#SBATCH -p normal,hns
#SBATCH --time=10
#SBATCH --nodes=1
#SBATCH -c 1

#!/bin/bash

ml load py-numpy
python similarity_to_known_clusters_distinct_timeline.py -datamatrix_timeline_folder /scratch/groups/khosla/Orphan_PKS/New_approach/Timeline/DistanceMatricesTimeline -knownPKS_folder /scratch/groups/khosla/Orphan_PKS/26MarDistanceTimeline 