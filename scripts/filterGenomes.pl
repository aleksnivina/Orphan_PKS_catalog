#!/usr/bin/perl -w

# Copyright (C) 2019 Maureen Hillenmeyer

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

use strict;

die "Usage: $0 clusterFile minClusterNum\n" unless @ARGV > 1;

my $clusterFile = shift @ARGV;
my $minClusterNum = shift @ARGV;

open(IN, $clusterFile) || die "Error, can't open file $clusterFile, exiting...\n";
while(<IN>) {
  chomp;
  my($genbank, $desc, $length, $clusterId, $numClusters, $clusterNames, $start, $end) = split("\t", $_);
  next unless $numClusters >= $minClusterNum;
  print "$_\n";
}
