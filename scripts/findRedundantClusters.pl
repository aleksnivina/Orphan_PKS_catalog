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

die "Usage:  cluster_file antismash_dir\n" unless @ARGV >= 2;

my $infile = shift;
my $antismash_dir = shift;

warn "Building GB sequences...\n";
my %gb_clusternum_seq = build_gb_seq($infile);
my %gb_clusternum_coords = build_gb_coords($infile);

warn "Iterating to compare for identical sequences...\n";
foreach my $gb1 (sort keys %gb_clusternum_seq) {
  my $clusternum_seq1 = $gb_clusternum_seq{$gb1};
  foreach my $clusternum1(sort keys %$clusternum_seq1) {
    my $seq1 = $gb_clusternum_seq{$gb1}{$clusternum1};
    my $coords1 = $gb_clusternum_coords{$gb1}{$clusternum1};
    my ($start1, $stop1) = split('-', $coords1);
    my $length1 = $stop1 - $start1;
  
    foreach my $gb2 (sort keys %gb_clusternum_seq) {
    my $clusternum_seq2 = $gb_clusternum_seq{$gb2};
      foreach my $clusternum2(sort keys %$clusternum_seq2) {
        my $seq2 = $gb_clusternum_seq{$gb2}{$clusternum2};
        my $coords2 = $gb_clusternum_coords{$gb2}{$clusternum2};
        my ($start2, $stop2) = split('-', $coords2);
        my $length2 = $stop2 - $start2;
  
        if($seq1 eq $seq2) {
          print "$gb1\t$clusternum1\t$coords1\t$gb2\t$clusternum2\t$coords2\t$length1\t$length2\n";
        }
	elsif($seq1 =~ /$seq2/ || $seq2 =~ /$seq1/) { ############################################## one is a substr of the other
          print "$gb1\t$clusternum1\t$coords1\t$gb2\t$clusternum2\t$coords2\t$length1\t$length2\tsubstring match\n";
	}
      }
    }
  }
}



exit;

sub build_gb_seq {
  my $infile = shift;
  my %gb_seq = ();
  open(GBSEQ, $infile);
  while(<GBSEQ>) {
    chomp;
    my($accession, $desc, $clusternum, $coords, $seq) = split("\t", $_);
    if(!$seq) {
      #next;
      die "Error, no seq for $accession\n";
    } 
    $gb_seq{$accession}{$clusternum} = $seq;
  }
  return %gb_seq;
}

sub build_gb_coords {
  my $infile = shift;
  my %gb_coords = ();
  open(GBCOORDS, $infile);
  while(<GBCOORDS>) {
    chomp;
    my($accession, $desc, $clusternum, $coords, $seq) = split("\t", $_);
    $gb_coords{$accession}{$clusternum} = $coords;
  }
  return %gb_coords;
}

