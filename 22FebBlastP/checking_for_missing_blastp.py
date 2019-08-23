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

parser = argparse.ArgumentParser(description='get the clusterfile and raw blast output folder')

parser.add_argument('--clusterfile')
parser.add_argument('--blastp_folder')

args=parser.parse_args()

cluster_file=args.clusterfile
blastp_folder=args.blastp_folder

# reading the cluster file and extracting clsuter IDs
with open(cluster_file,'r') as cluster_list_file:
    cluster_list=cluster_list_file.readlines()

cluster_ids=[]
for item in cluster_list:
    if item!="\n" and item!="":
        info=item.split("\t")
        accession=info[0]
        cluster_n=info[4][8:]
        cluster_ids.append((accession,cluster_n))

# first line is header, so exclude that
cluster_ids=cluster_ids[1:]
print len(cluster_ids)

with open("List_of_blastp_files_with_no_results.txt",'w') as missing_blastp_data_file:
    with open("List_of_missing_blastp_files.txt",'w') as missing_blastp_files:

        for item in cluster_ids:
    
            if len(item[1])==1:
                cluster_n="00"+item[1]
            elif len(item[1])==2:
                cluster_n="0"+item[1]
            else:
                print "Error in cluster number",item
    
            try:
                open(blastp_folder+"/"+item[0]+".cluster"+cluster_n+".fasta.blastp.out",'r')
        
            except:
                missing_blastp_files.write(blastp_folder+"/"+item[0]+".cluster"+cluster_n+".fasta.blastp.out\n")
            else:
                with open(blastp_folder+"/"+item[0]+".cluster"+cluster_n+".fasta.blastp.out",'r') as blastp_file:
                    for i in range(0,3):
                        curr_line=blastp_file.readline()
                        if curr_line=="":
                            missing_blastp_data_file.write(blastp_folder+"/"+item[0]+".cluster"+cluster_n+".fasta.blastp.out\n")
                            break
                
