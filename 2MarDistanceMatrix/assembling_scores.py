#!/usr/local/bin/python
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

# This script checks if all pairwise comparisons have values; if not: make these comparisons manually using 1-vs-1 blastp, and add them to the score file.

import argparse

parser = argparse.ArgumentParser(description='get the clusterfile and scorefile')

parser.add_argument('--clusterfile')
parser.add_argument('--scorefile_init')
parser.add_argument('--scorefile_additional')
parser.add_argument('--scorefile_yet_addit')
parser.add_argument('--scorefile_missing')
parser.add_argument('--outfolder')

args=parser.parse_args()

cluster_file=args.clusterfile
score_file_init=args.scorefile_init
score_file_addit=args.scorefile_additional
score_file_yet_addit=args.scorefile_yet_addit
score_file_missing=args.scorefile_missing
output_folder=args.outfolder

# reading the cluster file and extracting clsuter IDs
with open(cluster_file,'r') as cluster_list_file:
    cluster_list=cluster_list_file.readlines()

cluster_ids=[]
for item in cluster_list:
    if item!="\n" and item!="":
        info=item.split("\t")
        accession=info[0]
        cluster_n=info[4][8:]
        cluster_ids.append((accession+"."+cluster_n))

# first line is header, so exclude that
cluster_ids=cluster_ids[1:]
print len(cluster_ids)

# generating a dictionary for all pairwise comparisons, each with value 0
similarity_dict=dict([((query1,subject1),0) for query1 in cluster_ids for subject1 in cluster_ids]) 

print len(similarity_dict)

# for pairs that appear in the score file, increase value by 1 in the dictionary
with open(output_folder+"parsed_scores.all_final",'w') as final_score_file:
    with open(score_file_missing,'r') as score_list_file4:
        counter=True
        while counter:
            line=score_list_file4.readline()
            if line=="\n" or line=="":
                counter=False
                break
            else:
                info=line.split("\t")
                query2=info[0].split(" ")
                query2=query2[0]+"."+query2[1]
                subject2=info[1].split(" ")
                subject2=subject2[0]+"."+subject2[1]
                if (query2,subject2) in similarity_dict:
                    if similarity_dict[(query2,subject2)]==0:
                        final_score_file.write(line)
                        similarity_dict[(query2,subject2)]=1
    with open(score_file_yet_addit,'r') as score_list_file1:
        counter=True
        while counter:
            line=score_list_file1.readline()
            if line=="\n" or line=="":
                counter=False
                break
            else:
                info=line.split("\t")
                query2=info[0].split(" ")
                query2=query2[0]+"."+query2[1]
                subject2=info[1].split(" ")
                subject2=subject2[0]+"."+subject2[1]
                if (query2,subject2) in similarity_dict:
                    if similarity_dict[(query2,subject2)]==0:
                        final_score_file.write(line)
                        similarity_dict[(query2,subject2)]=1
    with open(score_file_addit,'r') as score_list_file2:
        counter=True
        while counter:
            line=score_list_file2.readline()
            if line=="\n" or line=="":
                counter=False
                break
            else:
                info=line.split("\t")
                query2=info[0].split(" ")
                query2=query2[0]+"."+query2[1]
                subject2=info[1].split(" ")
                subject2=subject2[0]+"."+subject2[1]
                if (query2,subject2) in similarity_dict:
                    if similarity_dict[(query2,subject2)]==0:
                        final_score_file.write(line)
                        similarity_dict[(query2,subject2)]=1
    with open(score_file_init,'r') as score_list_file3:
        counter=True
        while counter:
            line=score_list_file3.readline()
            if line=="\n" or line=="":
                counter=False
                break
            else:
                info=line.split("\t")
                query2=info[0].split(" ")
                query2=query2[0]+"."+query2[1]
                subject2=info[1].split(" ")
                subject2=subject2[0]+"."+subject2[1]
                if (query2,subject2) in similarity_dict:
                    if similarity_dict[(query2,subject2)]==0:
                        final_score_file.write(line)
                        similarity_dict[(query2,subject2)]=1



    