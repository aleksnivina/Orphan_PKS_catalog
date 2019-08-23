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
import Bio
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
from Bio import SeqIO

def find_known_clusters(accession,cluster_n,name_data,i):

    global known_cluster_descriptions
    stop=False

    # "biosynthetic"
    if name_data[i]=="biosynthetic" or name_data[i]=="Biosynthetic" or name_data[i]=="BIOSYNTHETIC":

        if accession=="AR159871" and cluster_n==1:
            print "Biosynthetic found"

        if len(name_data)>i+3:

            # "biosynthetic [...] for [...] X"
            if name_data[i+3]=="for" or name_data[i+3]=="For" or name_data[i+3]=="of" or name_data[i+3]=="Of" or name_data[i+3]=="OF" or name_data[i+3]=="FOR":
                initial_i1=i+3
                final_i2=len(name_data)

                # "biosynthetic [gene cluster for the] production of X"
                for i1 in range(i+3,len(name_data)):
                    if name_data[i1]=="production" or name_data[i1]=="Production" or name_data[i1]=="PRODUCTION":
                        initial_i1=i1+1
                        stop=True
                for i2 in range(initial_i1,len(name_data)):
                    if name_data[i2][-1]=="," or name_data[i2][-1]==")" or name_data[i2][-1]==";":
                        final_i2=i2+1
                        stop=True
                known_cluster_descriptions[(accession,cluster_n)]=" ".join(name_data[initial_i1+1:final_i2])
            
            # "X biosynthetic [...]"
            else:

                # "X X biosynthetic [...]"
                if len(name_data[i-1])<=5:
                    known_cluster_descriptions[(accession,cluster_n)]=" ".join(name_data[i-2:i])
                    stop=True

                # "X biosynthetic [...]"
                else:
                    known_cluster_descriptions[(accession,cluster_n)]=name_data[i-1]
                    stop=True

        # "X biosynthetic [...]"
        else:

            # "X X biosynthetic [...]"
            if len(name_data[i-1])<=5:
                known_cluster_descriptions[(accession,cluster_n)]=" ".join(name_data[i-2:i])
                stop=True

            # "X biosynthetic [...]"
            else:
                known_cluster_descriptions[(accession,cluster_n)]=name_data[i-1]
                stop=True


    # "(bio)synthesis"
    elif name_data[i]=="biosynthesis" or name_data[i]=="Biosynthesis" or name_data[i]=="synthesis" or name_data[i]=="Synthesis" or name_data[i]=="SYNTHESIS" or name_data[i]=="BIOSYNTHESIS":


        if accession=="AR159871" and cluster_n==1:
            print "Biosynthesis found"

        if len(name_data)>i+1:
            # "(bio)synthesis of X"
            if name_data[i+1]=="of" or name_data[i+1]=="Of" or name_data[i+1]=="for" or name_data[i+1]=="For" or name_data[i+1]=="FOR" or name_data[i+1]=="OF":
                known_cluster_descriptions[(accession,cluster_n)]=name_data[i+2]
                stop=True

            # "X (bio)synthesis gene/cluster"
            elif name_data[i+1]=="gene" or name_data[i+1]=="cluster" or name_data[i+1]=="Gene" or name_data[i+1]=="Cluster" or name_data[i+1]=="GENE" or name_data[i+1]=="CLUSTER":

                # "X X (bio)synthesis gene/cluster"
                if len(name_data[i-1])<=5:
                    known_cluster_descriptions[(accession,cluster_n)]=" ".join(name_data[i-2:i])
                    stop=True

                # "X (bio)synthesis gene/cluster"
                else:
                    known_cluster_descriptions[(accession,cluster_n)]=name_data[i-1]
                    stop=True

            # "X (bio)synthesis"
            else:

                # "X X (bio)synthesis gene/cluster"
                if len(name_data[i-1])<=5:
                    known_cluster_descriptions[(accession,cluster_n)]=" ".join(name_data[i-2:i])
                    stop=True

                # "X (bio)synthesis gene/cluster"
                else:
                    known_cluster_descriptions[(accession,cluster_n)]=name_data[i-1]
                    stop=True

        # "X (bio)synthesis"
        else:
             # "X X (bio)synthesis gene/cluster"
            if len(name_data[i-1])<=5:
                known_cluster_descriptions[(accession,cluster_n)]=" ".join(name_data[i-2:i])
                stop=True

            # "X (bio)synthesis gene/cluster"
            else:
                known_cluster_descriptions[(accession,cluster_n)]=name_data[i-1]
                stop=True

    # "gene"
    elif (name_data[i-1]!="biosynthetic" and name_data[i-1]!="Biosynthetic" and name_data[i-1]!="BIOSYNTHETIC")\
    and (name_data[i-1]!="biosynthesis" and name_data[i-1]!="Biosynthesis" and name_data[i-1]!="BIOSYNTHESIS")\
    and (name_data[i-1]!="synthesis" and name_data[i-1]!="synthesis" and name_data[i-1]!="SYNTHESIS")\
    and (name_data[i]=="gene" or name_data[i]=="Gene" or name_data[i]=="GENE"):


        if accession=="AR159871" and cluster_n==1:
            print "gene found"

        # "X synthase gene"
        if name_data[i-1]=="synthase" or name_data[i-1]=="Synthase" or name_data[i-1]=="SYNTHASE" or name_data[i-1]=="synthetase" or name_data[i-1]=="Synthetase" or name_data[i-1]=="SYNTHETASE":

            # "X X synthase gene"
            if len(name_data[i-2])<=5:
                known_cluster_descriptions[(accession,cluster_n)]=" ".join(name_data[i-3:i-1])
                stop=True

            # "X synthase gene"
            else:
                known_cluster_descriptions[(accession,cluster_n)]=name_data[i-2]
                stop=True

        # "X gene"
        else:

            # "X X gene"
            if len(name_data[i-1])<=5:
                known_cluster_descriptions[(accession,cluster_n)]=" ".join(name_data[i-2:i])
                stop=True

            # "X X gene"
            else:
                known_cluster_descriptions[(accession,cluster_n)]=name_data[i-1]
                stop=True

    elif (name_data[i-1]!="biosynthetic" and name_data[i-1]!="Biosynthetic" and name_data[i-1]!="BIOSYNTHETIC")\
    and (name_data[i-1]!="biosynthesis" and name_data[i-1]!="Biosynthesis" and name_data[i-1]!="BIOSYNTHESIS")\
    and (name_data[i-1]!="synthesis" and name_data[i-1]!="synthesis" and name_data[i-1]!="SYNTHESIS")\
    and (name_data[i]=="synthase" or name_data[i]=="Synthase" or name_data[i]=="SYNTHASE"):
        # if accession=="AR159871" and cluster_n==1:
        #     print "synthase found"

            # "X X synthase"
            if len(name_data[i-1])<=5:
                known_cluster_descriptions[(accession,cluster_n)]=" ".join(name_data[i-2:i])
                print "found",accession,cluster_n,known_cluster_descriptions[(accession,cluster_n)]
                stop=True

            elif name_data[i-1]=="polyketide" or name_data[i-1]=="Polyketide" or name_data[i-1]=="POLYKETIDE":
                if (name_data[i-2]!="typeI") and (name_data[i-2]!="TypeI") and (name_data[i-2]!="Type-I") and (name_data[i-2]!="type-I") and (name_data[i-3]!="type" and name_data[i-2]!="I") and (name_data[i-3]!="Type" and name_data[i-2]!="I"):
                    if len(name_data[i-2])<=5:
                        known_cluster_descriptions[(accession,cluster_n)]=" ".join(name_data[i-3:i-1])
                        print "found",accession,cluster_n,known_cluster_descriptions[(accession,cluster_n)]
                        top=True
                    else:
                        known_cluster_descriptions[(accession,cluster_n)]=name_data[i-2]
                        print "found",accession,cluster_n,known_cluster_descriptions[(accession,cluster_n)]
                        stop=True

            # "X synthase gene"
            else:
                known_cluster_descriptions[(accession,cluster_n)]=name_data[i-1]
                print "found",accession,cluster_n,known_cluster_descriptions[(accession,cluster_n)]
                stop=True

            # if accession=="AR159871" and cluster_n==1:
            # print "found",known_cluster_descriptions[(accession,cluster_n)]
    return stop



# reading the cluster file with non-identical records, and making a dictionary of cluster cordinates for each cluster ID.
# key = (accession,cluster_number); value = (start,end)
# with open("/scratch/groups/khosla/Orphan_PKS/10MarNonOrphans/clusterTableNonRedundant.6dbs.txt",'r') as nonidential_cluster_file:
with open("./clusterTableNonRedundant.6dbs.correct_domains.txt",'r') as nonidential_cluster_file:
    nonidentical_cluster_list=nonidential_cluster_file.readlines()
nonidentical_cluster_list=nonidentical_cluster_list[1:]
known_cluster_descriptions={}
for item in nonidentical_cluster_list:
    item_data=item.split("\t")
    accession=item_data[0]
    # print item_data[4]
    cluster_n=int(item_data[4][7:])
    name=item_data[1]
    name_data=name.split(" ")


    for i in range(0,len(name_data)):
        stop=find_known_clusters(accession,cluster_n,name_data,i)
        if stop:
            break

    redundant_clusters=item_data[11].split(";")
    for redundant_cluster in redundant_clusters:
        redundant_cluster=redundant_cluster.split(" ")
        description=redundant_cluster[4:]
        for i in range(0,len(description)):
            stop=find_known_clusters(accession,cluster_n,description,i)
            if stop:
                break



    

with open("known_PKS_clusters_from_clusterTable_additional.txt",'w') as output_file1: 

    for key in known_cluster_descriptions:
        product=known_cluster_descriptions[key].strip("\n")
        if product[0].islower:
            product=product[0].capitalize()+product[1:]
        output_file1.write(key[0]+" "+str(key[1])+":\t"+product+"\n")
        # print key, known_cluster_descriptions[key]


