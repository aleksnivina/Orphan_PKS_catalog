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

die "Usage: $0 tableFile\n" unless @ARGV >= 1;

my $file = shift @ARGV;

my %accession_cluster_domains = build_accession_cluster_domains($file);
my %accession_species = build_hash_from_cols($file,0,3);

foreach my $accession1(sort keys %accession_cluster_domains) {
  my $species1 = $accession_species{$accession1};
  my $clusters1 = $accession_cluster_domains{$accession1};
  foreach my $cluster1 (sort keys %$clusters1) {
    my $domains1 = $accession_cluster_domains{$accession1}{$cluster1};
    foreach my $accession2(sort keys %accession_cluster_domains) {
      next if $accession1 eq $accession2;
      my $species2 = $accession_species{$accession2};
      my $clusters2 = $accession_cluster_domains{$accession2};
      foreach my $cluster2 (sort keys %$clusters2) {
        my $domains2 = $accession_cluster_domains{$accession2}{$cluster2};
        if( ($species1 eq $species2) && ($domains1 eq $domains2) ) {
          print "$accession1\t$cluster1\t$accession2\t$cluster2\t$species1\t$domains1\n";
        }
      }
    }
  }
}

sub build_accession_cluster_domains {
my $file = shift;
my %hash = ();
open(DOMAINS, $file);
my $header = <DOMAINS>;
while(<DOMAINS>) {
  chomp;
  my(@info) = split("\t", $_);
  my (@domains) = @info[9..16];
  my $domains = join("\t", @domains);
  #print "$info[0]\t$domains\n";
  $hash{$info[0]}{$info[4]} = $domains;
}
close(DOMAINS);
return %hash;
}


sub build_hash_from_cols {
  my($file, $col1, $col2) = @_;
  #unless(-e $file) {warn "Warning:  $file doesn't exist\n";}
  open(TWOCOL, $file) || warn "Warning:  error opening $file:  $!\n";
  my %hash;
  while(<TWOCOL>) {
    chomp;
    my(@info) = split("\t", $_);
    next unless $info[$col1];
    $hash{$info[$col1]} = $info[$col2];
  }
  return %hash;
}

