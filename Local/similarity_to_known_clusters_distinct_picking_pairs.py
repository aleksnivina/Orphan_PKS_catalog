# Copyright (C) 2019 Aleksandra Nivina

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# To see the GNU General Public License, Plesase see 
# <http://www.gnu.org/licenses/>.

import numpy as np
import matplotlib
matplotlib.use('TkAgg')
import matplotlib.pyplot as plt
import seaborn as sns
sns.set_style(style="whitegrid")
import matplotlib.colors as mcolors
colors = dict(mcolors.BASE_COLORS, **mcolors.CSS4_COLORS)
import random
import os
from os.path import isfile,isdir, join

def cluster_number(cluster_n):
	if len(cluster_n)==1:
		cluster_num="00"+cluster_n
	elif len(cluster_n)==2:
		cluster_num="0"+cluster_n
	else:
		cluster_num=cluster_n
	return cluster_num

set_name="Set3"
os.mkdir(set_name+"_dissimilar")
os.mkdir(set_name+"_similar")

known_clusters_main={}
cluster_to_product={}
with open("../../10_looking_for_nonorphans/known_clusters_MIBig_and_clusterTable_matched_to_main_edited.txt",'r') as known_cluster_file:
	known_cluster_list=known_cluster_file.readlines()
for line in known_cluster_list:
    cluster_info=line.split("\t")
    cluster_id=cluster_info[0].strip(":")
    product=cluster_info[1].strip("\n")
    known_clusters_main[cluster_id]=0
    cluster_to_product[cluster_id]=product


with open("../../12_plotting_dendrograms/clusterTableNonRedundantNonSimilarNonSequenceSimilar.6dbs.prot_len.correct_domains.txt",'r') as distinct_cluster_file:
	distinct_cluster_list=distinct_cluster_file.readlines()

distinct_cluster_ids={}
for i in range(1,len(distinct_cluster_list)):
	line=distinct_cluster_list[i].split("\t")
	accession=line[0]
	cluster_num=line[4].split(" ")[1]
	cluster_id=accession+" "+cluster_num
	distinct_cluster_ids[cluster_id]=0


print "There are",len(known_clusters_main),"known clusters."

n_found_similar=0
n_found_dissimilar=0
known_cluster_indices=[]
distances_to_known_clusters=[]

with open("../../5_creating_distancematrix/dataMatrix_blastp.txt",'r') as data_matrix_file:
	data_matrix_data=data_matrix_file.readlines()

with open("List_of_chosen_similar_pairs_"+set_name+".txt",'w') as output_file1:
	with open("List_of_chosen_dissimilar_pairs_"+set_name+".txt",'w') as output_file2:
			header_data=data_matrix_data[0].split("\t")
			known_cluster_indices_to_ids={}

			# making a list of indices that correspond to known clusters
			for i in range(1,len(header_data)):
				curr_cluster=header_data[i].split(" ")
				curr_accession=curr_cluster[0]
				curr_clusternum=curr_cluster[1]
				curr_cluster_id=curr_accession+" "+curr_clusternum
				if (curr_cluster_id in known_clusters_main) and (curr_cluster_id in distinct_cluster_ids):
					known_cluster_indices.append(i)
					known_clusters_main[curr_cluster_id]=1
					known_cluster_indices_to_ids[i]=curr_cluster_id

			print "There are",len(known_cluster_indices),"known clusters found in the data matrix."
			for key in known_clusters_main:
				if known_clusters_main[key]==0:
					print "Didn't find",key

			# going through random orphan clusters to find 10 that are <50% similar to a known cluster, and 10 that are >50% similar to a known cluster
			end_of_file=False
			while n_found_similar<10 or n_found_dissimilar<10:

				# choosing a random index
				index=random.choice(np.arange(1,len(data_matrix_data)-1))
				# then making sure that it's not a known cluster
				if index not in known_cluster_indices:
					line=data_matrix_data[index]

					line_data=line.split("\t")
					description=line_data[0].split(" ")
					curr_accession=description[0]
					curr_cluster_n=description[1]
					curr_cluster_id=curr_accession+" "+curr_cluster_n

					# only for orphan clusters in the main cluster table
					if curr_cluster_id in distinct_cluster_ids:
						max_similarity=0.0
						max_k_index=0
						for k in known_cluster_indices:
							similarity=1.0-float(line_data[k])
							if similarity>max_similarity:
								max_similarity=similarity
								max_k_index=k
						if max_similarity<=0.50 and n_found_dissimilar<10:
							n_found_dissimilar+=1
							known_cluster=known_cluster_indices_to_ids[max_k_index]
							known_cluster_accession=known_cluster.split(" ")[0]
							known_cluster_n=known_cluster.split(" ")[1]
							known_cluster_num=cluster_number(known_cluster_n)
							current_cluster_num=cluster_number(curr_cluster_n)
							known_product=cluster_to_product[known_cluster]
							output_file2.write(known_cluster+"\t"+known_product+"\t"+curr_cluster_id+"\t"+str(max_similarity)+"\n")

							if not isdir("./"+set_name+"_dissimilar/"+known_cluster_accession):
								os.mkdir("./"+set_name+"_dissimilar/"+known_cluster_accession)
							command="scp -r nivina@login.sherlock.stanford.edu:/home/groups/khosla/Orphan_PKS/6dbs_prescreen/"+known_cluster_accession+"/"+known_cluster_accession+".cluster"+known_cluster_num+".gbk "\
								+"nivina@login.sherlock.stanford.edu:/home/groups/khosla/Orphan_PKS/6dbs_prescreen/"+curr_accession+"/"+curr_accession+".cluster"+current_cluster_num+".gbk "\
								+"./"+set_name+"_dissimilar/"+known_cluster_accession+"/"
							os.system(command)


						elif max_similarity>0.50:
							n_found_similar+=1
							known_cluster=known_cluster_indices_to_ids[max_k_index]
							known_cluster_accession=known_cluster.split(" ")[0]
							known_cluster_n=known_cluster.split(" ")[1]
							known_cluster_num=cluster_number(known_cluster_n)
							current_cluster_num=cluster_number(curr_cluster_n)
							known_product=cluster_to_product[known_cluster]
							output_file1.write(known_cluster+"\t"+known_product+"\t"+curr_cluster_id+"\t"+str(max_similarity)+"\n")

							if not isdir("./"+set_name+"_similar/"+known_cluster_accession):
								os.mkdir("./"+set_name+"_similar/"+known_cluster_accession)
							command="scp -r nivina@login.sherlock.stanford.edu:/home/groups/khosla/Orphan_PKS/6dbs_prescreen/"+known_cluster_accession+"/"+known_cluster_accession+".cluster"+known_cluster_num+".gbk "\
								+"nivina@login.sherlock.stanford.edu:/home/groups/khosla/Orphan_PKS/6dbs_prescreen/"+curr_accession+"/"+curr_accession+".cluster"+current_cluster_num+".gbk "\
								+"./"+set_name+"_similar/"+known_cluster_accession+"/"
							os.system(command)



