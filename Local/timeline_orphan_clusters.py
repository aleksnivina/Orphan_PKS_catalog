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


with open("Orphan_cluster_similarities_to_known_timeline_numbers_new.txt",'r') as orphan_type_file:
	orphan_type_timeline=orphan_type_file.readlines()

years=range(1994,2019)

truly_orphan=orphan_type_timeline[1].strip("\n").split("\t")
truly_orphan=[float(x) for x in truly_orphan]

possibly_homologs=orphan_type_timeline[3].strip("\n").split("\t")
possibly_homologs=[float(x) for x in possibly_homologs]

redundant=orphan_type_timeline[5].strip("\n").split("\t")
redundant=[float(x) for x in redundant]

known=orphan_type_timeline[7].strip("\n").split("\t")
known=[float(x) for x in known]



labels=[1995,2000,2005,2010,2015]
fig1 = plt.figure(figsize=(5,4))
ax1 = plt.axes()
pos1 = ax1.get_position()
pos2 = [pos1.x0, pos1.y0 + 0.1,  pos1.width / 2, pos1.height / 1.5]
ax1.set_position(pos2)
ax1.set_xlim(1994,2019)
# ax1.set_xlim(1994,2018)
# ax1.set_xlabel("")
ax1.set_xticks(labels)
ax1.set_xticklabels(labels, rotation=90) #, rotation=90
# ax1.set_yscale('log')
# ax1.set_ylim(0,3200)
ax1.set_ylim(0,4000)
ax1.set_ylabel("Number of clusters")
ax1.grid(False)
# ax1.spines['left'].set_color('red')

# plt.plot(years,truly_orphan,color="lightgrey")
# plt.plot(years,possibly_homologs,color="grey")
# plt.plot(years,redundant,color="black")
# plt.plot(years,known,color="red")

plt.plot(years[:-1],truly_orphan[:-1],color="lightgrey")
plt.plot(years[:-1],possibly_homologs[:-1],color="grey")
plt.plot(years[:-1],redundant[:-1],color="black")
plt.plot(years[:-1],known[:-1],color="red")


plt.legend(["Truly orphan clusters","Possibly homologous\nto known clusters","Redundant\nto known clusters","Known clusters"],bbox_to_anchor=(pos1.x0+1,pos1.y0+0.5,1,0.2))
plt.title("Increase in the number\nof orphan clusters")
plt.savefig("Numbers_of_orphan_clusters_timeline_until2017.pdf")

