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



redund1994="./ParsedScores/parsed_scores.1994.redundant_chained.cutoff0.9.txt"
redund1995="./ParsedScores/parsed_scores.1995.redundant_chained.cutoff0.9.txt"
redund1996="./ParsedScores/parsed_scores.1996.redundant_chained.cutoff0.9.txt"
redund1997="./ParsedScores/parsed_scores.1997.redundant_chained.cutoff0.9.txt"
redund1998="./ParsedScores/parsed_scores.1998.redundant_chained.cutoff0.9.txt"
redund1999="./ParsedScores/parsed_scores.1999.redundant_chained.cutoff0.9.txt"
redund2000="./ParsedScores/parsed_scores.2000.redundant_chained.cutoff0.9.txt"
redund2001="./ParsedScores/parsed_scores.2001.redundant_chained.cutoff0.9.txt"
redund2002="./ParsedScores/parsed_scores.2002.redundant_chained.cutoff0.9.txt"
redund2003="./ParsedScores/parsed_scores.2003.redundant_chained.cutoff0.9.txt"
redund2004="./ParsedScores/parsed_scores.2004.redundant_chained.cutoff0.9.txt"
redund2005="./ParsedScores/parsed_scores.2005.redundant_chained.cutoff0.9.txt"
redund2006="./ParsedScores/parsed_scores.2006.redundant_chained.cutoff0.9.txt"
redund2007="./ParsedScores/parsed_scores.2007.redundant_chained.cutoff0.9.txt"
redund2008="./ParsedScores/parsed_scores.2008.redundant_chained.cutoff0.9.txt"
redund2009="./ParsedScores/parsed_scores.2009.redundant_chained.cutoff0.9.txt"
redund2010="./ParsedScores/parsed_scores.2010.redundant_chained.cutoff0.9.txt"
redund2011="./ParsedScores/parsed_scores.2011.redundant_chained.cutoff0.9.txt"
redund2012="./ParsedScores/parsed_scores.2012.redundant_chained.cutoff0.9.txt"
redund2013="./ParsedScores/parsed_scores.2013.redundant_chained.cutoff0.9.txt"
redund2014="./ParsedScores/parsed_scores.2014.redundant_chained.cutoff0.9.txt"
redund2015="./ParsedScores/parsed_scores.2015.redundant_chained.cutoff0.9.txt"
redund2016="./ParsedScores/parsed_scores.2016.redundant_chained.cutoff0.9.txt"
redund2017="./ParsedScores/parsed_scores.2017.redundant_chained.cutoff0.9.txt"
redund2018="./ParsedScores/parsed_scores.2018.redundant_chained.cutoff0.9.txt"

nonredund1994="./ParsedScores/parsed_scores.1994.nonredundant_chained.cutoff0.9.txt"
nonredund1995="./ParsedScores/parsed_scores.1995.nonredundant_chained.cutoff0.9.txt"
nonredund1996="./ParsedScores/parsed_scores.1996.nonredundant_chained.cutoff0.9.txt"
nonredund1997="./ParsedScores/parsed_scores.1997.nonredundant_chained.cutoff0.9.txt"
nonredund1998="./ParsedScores/parsed_scores.1998.nonredundant_chained.cutoff0.9.txt"
nonredund1999="./ParsedScores/parsed_scores.1999.nonredundant_chained.cutoff0.9.txt"
nonredund2000="./ParsedScores/parsed_scores.2000.nonredundant_chained.cutoff0.9.txt"
nonredund2001="./ParsedScores/parsed_scores.2001.nonredundant_chained.cutoff0.9.txt"
nonredund2002="./ParsedScores/parsed_scores.2002.nonredundant_chained.cutoff0.9.txt"
nonredund2003="./ParsedScores/parsed_scores.2003.nonredundant_chained.cutoff0.9.txt"
nonredund2004="./ParsedScores/parsed_scores.2004.nonredundant_chained.cutoff0.9.txt"
nonredund2005="./ParsedScores/parsed_scores.2005.nonredundant_chained.cutoff0.9.txt"
nonredund2006="./ParsedScores/parsed_scores.2006.nonredundant_chained.cutoff0.9.txt"
nonredund2007="./ParsedScores/parsed_scores.2007.nonredundant_chained.cutoff0.9.txt"
nonredund2008="./ParsedScores/parsed_scores.2008.nonredundant_chained.cutoff0.9.txt"
nonredund2009="./ParsedScores/parsed_scores.2009.nonredundant_chained.cutoff0.9.txt"
nonredund2010="./ParsedScores/parsed_scores.2010.nonredundant_chained.cutoff0.9.txt"
nonredund2011="./ParsedScores/parsed_scores.2011.nonredundant_chained.cutoff0.9.txt"
nonredund2012="./ParsedScores/parsed_scores.2012.nonredundant_chained.cutoff0.9.txt"
nonredund2013="./ParsedScores/parsed_scores.2013.nonredundant_chained.cutoff0.9.txt"
nonredund2014="./ParsedScores/parsed_scores.2014.nonredundant_chained.cutoff0.9.txt"
nonredund2015="./ParsedScores/parsed_scores.2015.nonredundant_chained.cutoff0.9.txt"
nonredund2016="./ParsedScores/parsed_scores.2016.nonredundant_chained.cutoff0.9.txt"
nonredund2017="./ParsedScores/parsed_scores.2017.nonredundant_chained.cutoff0.9.txt"
nonredund2018="./ParsedScores/parsed_scores.2018.nonredundant_chained.cutoff0.9.txt"

print "opened all files"
unique_cluster_numbers=[0 for i in range(1994,2019)]
redundant_set_numbers=[0 for i in range(1994,2019)]
redundant_percentages=[0 for i in range(1994,2019)]

years=range(1994,2019)

redund_file_list=[redund1994,redund1995,redund1996,redund1997,redund1998,redund1999,redund2000,\
redund2001,redund2002,redund2003,redund2004,redund2005,redund2006,redund2007,redund2008,\
redund2009,redund2010,redund2011,redund2012,redund2013,redund2014,redund2015,redund2016,\
redund2017,redund2018]

nonredund_file_list=[nonredund1994,nonredund1995,nonredund1996,nonredund1997,nonredund1998,nonredund1999,nonredund2000,\
nonredund2001,nonredund2002,nonredund2003,nonredund2004,nonredund2005,nonredund2006,nonredund2007,nonredund2008,\
nonredund2009,nonredund2010,nonredund2011,nonredund2012,nonredund2013,nonredund2014,nonredund2015,nonredund2016,\
nonredund2017,nonredund2018]

for i in range(0,len(years)):
	nonredund_file=open(nonredund_file_list[i],'r')
	nonredund_clusters=nonredund_file.readlines()
	nonredund_file.close()
	n_nonredund_clusters=len(nonredund_clusters)-1
	unique_cluster_numbers[i]+=n_nonredund_clusters

	redund_file=open(redund_file_list[i],'r')
	redund_cluster_sets=redund_file.readlines()
	redund_file.close()
	n_redund_cluster_sets=len(redund_cluster_sets)-1
	unique_cluster_numbers[i]+=n_redund_cluster_sets
	redundant_set_numbers[i]=n_redund_cluster_sets

	if unique_cluster_numbers[i]!=0:
		redundant_percentages[i]=np.round(float(redundant_set_numbers[i])/float(unique_cluster_numbers[i])*100,1)


	
print "counted numbers"
with open("Timeline_unique_redundant_clusters.txt",'w') as outputfile:
	outputfile.write("Year\tUnique clusters\tNumber of duplicate sets\tPercentage of duplicate sets\n")
	for k in range(0,len(years)):
		outputfile.write("\t".join([str(years[k]),str(unique_cluster_numbers[i]),str(redundant_set_numbers[i]),str(redundant_percentages[i])]))
		outputfile.write("\n")

plt.figure(1)
fig,ax1=plt.subplots(figsize=(4, 4))
ax1.set_xlim(1993,2019)
ax1.set_yscale('log')
ax1.set_ylim(1E0,1E4)
plt.plot(years,unique_cluster_numbers)

ax2=ax1.twinx()
ax2.set_ylim(0,100)
plt.plot(years,redundant_percentages)

plt.savefig("Timeline_unique_redundanT-cluster.png")







