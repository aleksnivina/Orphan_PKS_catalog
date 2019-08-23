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

# 
# Choose one synonym, skip the rest.
# Choose the first for now.
# Print the synonymous accession #s at the end.
#


use strict;

die "Usage $0 tableFile similarFile\n" unless @ARGV >= 3;

my $table_file = shift;
my $similar_file = shift;
my $accession_desc_file = shift;
my $date_file = shift;

my %gb_synonyms = build_gb_synonyms($similar_file); # key = accession_clusternum1, key2 = accession_clusternum2
my %accession_desc = build_accession_desc_no_version($accession_desc_file);
my %accession_year = build_accession_year($date_file);

# Oct 2013
my %accession_clusternum_length = build_accession_clusternum_length($table_file);

my %skip = ();



open(IN, $table_file);
my $header = <IN>;
chomp $header;
print "$header\tClusters with identical architecture in this species\n";

while(<IN>) {
  chomp;
  my(@info) = split("\t", $_);
  # Need accession and clusternum
  my $accession = $info[0];
  my $year = $info[2];
  my $clusternum = $info[4];
  my $length = $info[7];
  my $accession_clusternum = "$accession\t$clusternum";
  my $desc = $accession_desc{$accession};

  if($skip{$accession_clusternum}) {next;} #################################################### ?
  #my $longest_length = $length; # if use the check below


  # Get synonyms for this gb (from synonym file)
  my $synonyms = $gb_synonyms{$accession_clusternum};
  #my $year = $accession_year{$accession};
  my $synonym_str = "$accession Date=$year $clusternum $length"."bp"." $desc";

  # Iterate synonyms and choose first, make a note of it
  foreach my $synonym (keys %$synonyms) {
    my($syn_accession, $syn_clusternum) = split("\t", $synonym);
    next if($accession eq $syn_accession);
    $skip{$synonym} = 1; #################################################### ?
    my $syn_desc = $accession_desc{$syn_accession};
    my $syn_year = $accession_year{$syn_accession};
    my $syn_length = $accession_clusternum_length{$syn_accession}{$syn_clusternum};

# TODO: add this check/edit to change the accession number?
#    if($syn_length > $longest_length) {
#      $longest_length = $syn_length;
#      $print_accession = $syn_accession; # if this synonym is longest, print this one instead
#      $print_clusternum = $syn_clusternum;
#      $print_desc = $syn_desc;
#      $print_coords = $syn_coords;
#    }


    # Is this year the oldest?  If so, reset the year and the desc/species
   #if($syn_year < $year) {
   if($syn_year < $info[2]) {
      $info[2] = $syn_year;
      #$info[0] = $syn_accession;
      #$info[4] = $syn_clusternum;
      $info[1] = "$info[1]; $syn_desc";
      ##$info[3] = $syn_species; # TODO add
    }



    #$synonym_str .= "; $syn_accession "."cluster$syn_clusternum $syn_length"."bp"." $syn_desc"; # Add the info for this synonym to the string
    #$synonym_str .= "; $syn_accession Date=$syn_year "."$syn_clusternum $syn_desc"; # Add the info for this synonym to the string
    $synonym_str .= "; $syn_accession Date=$syn_year "."$syn_clusternum $syn_length"."bp"." $syn_desc"; # Oct 2013

  }

  my $line_new = join("\t", @info);
  print "$line_new\t$synonym_str\n";
  #print "$_\t$synonym_str\n";
}



sub build_gb_synonyms {
  my $infile = shift;
  my %synonyms = ();
  open(GB, $infile);
  while(<GB>) {
    chomp;
    my($accession1, $clusternum1, $accession2, $clusternum2, @rest) = split("\t", $_);
    my $accession_clusternum1 = "$accession1\t$clusternum1";
    my $accession_clusternum2 = "$accession2\t$clusternum2";

    # skip self-self ones?
    $synonyms{$accession_clusternum1}{$accession_clusternum2} = 1;
    $synonyms{$accession_clusternum2}{$accession_clusternum1} = 1;
  }
  close(GB);
  return %synonyms;
}

sub build_accession_desc_no_version{
  my($file) = shift;
  open(TWOCOL, $file) || die "Error can't open $file\n";
  my %hash;
  while(<TWOCOL>) {
    chomp;
    my($first, $second, @rest) = split("\t", $_);
    my $accession = $first;
    if ($first =~ /(.*)\.\d/) {
      $accession = $1;
    }
    $hash{$accession} = $second;
  }
  close(TWOCOL);
  return %hash;
}


sub build_accession_year {
  my $file = shift;
  my %hash = ();
  my %accession_date = build_hash_from_two_cols($file);
  foreach my $accession(keys %accession_date) {
    my $date = $accession_date{$accession};
    $date =~ /(.*)\-(.*)\-(.*)/;
    my $year = $3 || "Error in year";
    $hash{$accession} = $year;
  }
  return (%hash);
}

sub build_hash_from_two_cols {
  my($file) = @_;
  open(TWOCOL, $file) || die "Can't open $file\n";
  my %hash;
  while(<TWOCOL>) {
    chomp;
    my($first, $second, @rest) = split("\t", $_);
    $hash{$first} = $second;
  }
  return %hash;
}


sub build_accession_clusternum_length {
  my $file = shift;
  my %hash = ();
  open(LEN, $file);
  while(<LEN>) {
    chomp;
    my(@info) = split("\t", $_);
    $hash{$info[0]}{$info[4]} = $info[7];
  }
  return (%hash);
}



