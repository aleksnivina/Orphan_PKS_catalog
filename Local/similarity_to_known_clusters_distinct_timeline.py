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
import argparse

parser = argparse.ArgumentParser(description='Where to get and write files')
parser.add_argument('-datamatrix_timeline_folder','--datamatrixfolder')
# parser.add_argument('-clusterNRNSNSS_folder','--clusterfolder')
parser.add_argument('-knownPKS_folder','--knownPKSfolder')
args=parser.parse_args()
datamatrix_folder=args.datamatrixfolder


def count_percentage(distance_list):
	n_orphan=0
	n_homologous=0
	n_redundant=0
	for item in distance_list:
		if item>=0.9:
			n_redundant+=1
		elif item>=0.5:
			n_homologous+=1
		else:
			n_orphan+=1
	percent_orphan=str(np.round(float(n_orphan)/float(len(distance_list))*100,2))
	percent_homologous=str(np.round(float(n_homologous)/float(len(distance_list))*100))
	percent_redundant=str(np.round(float(n_redundant)/float(len(distance_list))*100))
	return percent_orphan,percent_homologous,percent_redundant

def count_numbers(distance_list):
	n_orphan=0
	n_homologous=0
	n_redundant=0
	for item in distance_list:
		if item>=0.9:
			n_redundant+=1
		elif item>=0.5:
			n_homologous+=1
		else:
			n_orphan+=1
	return str(n_orphan),str(n_homologous),str(n_redundant)



# for i in range(1,len(distinct_cluster_list)):
# 	line=distinct_cluster_list[i].split("\t")
# 	accession=line[0]
# 	cluster_num=line[4].split(" ")[1]
# 	cluster_id=accession+" "+cluster_num
# 	distinct_cluster_ids[cluster_id]=0

known_clusters_all={}
with open("./known_clusters_MIBig_and_clusterTable_edited.txt",'r') as known_cluster_file:
	known_cluster_list=known_cluster_file.readlines()
for line in known_cluster_list:
    cluster_info=line.split("\t")
    cluster_id=cluster_info[0].strip(":")
    product=cluster_info[1].strip("\n")
    known_clusters_all[cluster_id]=0

with open("./known_clusters_MIBig_and_clusterTable_matched_to_all_leaves_edited.txt",'r') as known_cluster_file2:
	known_cluster_list2=known_cluster_file2.readlines()
for line in known_cluster_list2:
    cluster_info=line.split("\t")
    cluster_id=cluster_info[0].strip(":")
    product=cluster_info[1].strip("\n")
    if cluster_id not in known_clusters_all:
	    known_clusters_all[cluster_id]=0

with open("./known_clusters_MIBig_and_clusterTable_matched_to_main_edited.txt",'r') as known_cluster_file3:
	known_cluster_list3=known_cluster_file3.readlines()
for line in known_cluster_list3:
    cluster_info=line.split("\t")
    cluster_id=cluster_info[0].strip(":")
    product=cluster_info[1].strip("\n")
    if cluster_id not in known_clusters_all:
	    known_clusters_all[cluster_id]=0	  

years=range(1994,2019)
# years=[2018]


percent_truly_orphan_timeline=[]
percent_possibly_homologous_timeline=[]
percent_redundant_timeline=[]

number_truly_orphan_timeline=[]
number_possibly_homologous_timeline=[]
number_redundant_timeline=[]

number_known_timeline=[]

mean_similarity_timeline=[]

for year in years:
	known_cluster_indices=[]
	distances_to_known_clusters=[]
	n_known=0

	# finding clusters that are redundant for that year
	redundant_references={}
	main_clusters={}
	with open(datamatrix_folder+"/../ParsedScoresTimeline/parsed_scores."+str(year)+".redundant_chained.cutoff0.9.txt",'r') as redundant_file:
		redundant_list=redundant_file.readlines()
	for line2 in redundant_list:
		similar_clusters=line2.strip("\n").split("\t")
		while "\t" in similar_clusters:
			similar_clusters.remove("\t")
		main_cluster=similar_clusters[0]
		main_clusters[main_cluster]=1
		redund_clusters=similar_clusters[1:]
		for redund_cluster in redund_clusters:
			redundant_references[redund_cluster]=main_cluster

	with open(datamatrix_folder+"/../ParsedScoresTimeline/parsed_scores."+str(year)+".nonredundant_chained.cutoff0.9.txt",'r') as nonredundant_file:
		nonredundant_list=nonredundant_file.readlines()
	for line3 in nonredundant_list:
		main_cluster=line3.strip("\n")
		main_clusters[main_cluster]=1


	if year==2005:
		print "Redundant references:"
		for key in redundant_references:
			print key,":",redundant_references[key]
		print "\n\n\n"

	# going through the distance matrix
	with open(datamatrix_folder+"/distanceMatrix"+str(year)+".txt",'r') as data_matrix_file:
		header=data_matrix_file.readline()
		header_data=header.split("\t")

		# making a list of indices that correspond to known clusters
		for i in range(1,len(header_data)):
			curr_cluster=header_data[i].split(" ")
			curr_accession=curr_cluster[0]
			curr_clusternum=curr_cluster[1]
			curr_cluster_id=curr_accession+" "+curr_clusternum

			# either the cluster itself is known
			if curr_cluster_id in known_clusters_all:
				known_cluster_indices.append(i)

			# or it's the main leaf for a known cluster
			if curr_cluster_id in redundant_references:
				main_cluster_id=redundant_references[curr_cluster_id]
				if main_cluster_id in known_clusters_all:
					known_cluster_indices.append(header_data.index(main_cluster_id))


		end_of_file=False
		while not end_of_file:
			line=data_matrix_file.readline()

			if line=="\n" or line=="":
				end_of_file=False
				break

			line_data=line.split("\t")
			description=line_data[0].split(" ")
			curr_accession=description[0]
			curr_clusternum=description[1]
			curr_cluster_id=curr_accession+" "+curr_clusternum


			# only count this for main leaves
			if curr_cluster_id in main_clusters:

				if year==2005:
					print "cluster",curr_cluster_id,"considered to be main"

				# if it's known, record it as such
				if curr_cluster_id in known_clusters_all:
					n_known+=1

				# if it's not known, record the max similarity
				else:
					max_similarity=0.0
					for k in known_cluster_indices:
						similarity=1.0-float(line_data[k])
						if similarity>max_similarity:
							max_similarity=similarity
					distances_to_known_clusters.append(max_similarity)

			else:
				if year==2005:
					if curr_cluster_id in redundant_references:
						print "cluster",curr_cluster_id,"considered to be redundant to", redundant_references[curr_cluster_id]
					else:
						print "!!! cluster",curr_cluster_id,"considered to be redundant to another cluster, even though it's not among redundant references"




			# # only recording distance info for orphan clusters; only for distinct clusters
			# if (curr_cluster_id not in known_clusters_all) and (curr_cluster_id in distinct_cluster_ids):
			# 	max_similarity=0.0
			# 	for k in known_cluster_indices:
			# 		similarity=1.0-float(line_data[k])
			# 		if similarity>max_similarity:
			# 			max_similarity=similarity
			# 	distances_to_known_clusters.append(max_similarity)

	# percent_truly_orphan,percent_possibly_homologous,percent_redundant=count_percentage(distances_to_known_clusters)
	number_truly_orphan,number_possibly_homologous,number_redundant=count_numbers(distances_to_known_clusters)
	
	# percent_truly_orphan_timeline.append(percent_truly_orphan)
	# percent_possibly_homologous_timeline.append(percent_possibly_homologous)
	# percent_redundant_timeline.append(percent_redundant)
	number_truly_orphan_timeline.append(number_truly_orphan)
	number_possibly_homologous_timeline.append(number_possibly_homologous)
	number_redundant_timeline.append(number_redundant)
	number_known_timeline.append(str(n_known))
	# mean_similarity_timeline.append(str(np.round(np.mean(distances_to_known_clusters),4)))




with open("Orphan_distinct_cluster_similarities_to_known_timeline_numbers_new.txt",'w') as output_file:
	output_file.write("Truly orphan:\n")
	output_file.write("\t".join(number_truly_orphan_timeline))
	output_file.write("\nPossibly homologous:\n")
	output_file.write("\t".join(number_possibly_homologous_timeline))
	output_file.write("\nRedundant:\n")
	output_file.write("\t".join(number_redundant_timeline))
	output_file.write("\nKnown:\n")
	output_file.write("\t".join(number_known_timeline))


# for k in range(0,len())






