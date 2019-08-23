#!/usr/bin/perl -w

# Copyright (C) 2019 Maureen Hillenmeyer, Jake Hsu

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
#jake hsu edit
#This has been modified to find the start and end coordinates a little differently
# The start coordinates are the js file near the phrase "knowncluster" so look there
die "Usage: $0 accession_desc_file antismash_dir out_dir numKS\n" unless @ARGV >= 4;

my $accession_desc_file= shift;
my $antismash_batch_dir = shift;
my $output_folder = shift;
my $min_antismash_ks_num = shift;

# Outfile
my $outfile = "$output_folder/interestingClusters.txt";
my $no_results_outfile = "$output_folder/noAntismashResults.txt";
open(OUT, ">$outfile");
open(OUTNORESULT, ">$no_results_outfile");

# Accession description
my %accession_desc = build_hash_from_two_cols($accession_desc_file);
# Note that this should have 2826 lines
#print_hash(%accession_desc);
#exit;

my $debug = "SERERYAB";

foreach my $accession (sort keys %accession_desc) {
 
  # DEBUG
  #print "$accession\n"; # should lead to 2826 lines - yes. (2829 with extra at bottom)
  #next;
  #next unless $accession =~ /SER/; ########### debug


  #########################################################################
  # Antismash info
  # strip version
  $accession =~ /(.*)\.\d+/;
  my $antismash_accession = $1 || $accession;
  my $desc = $accession_desc{$accession};


  # DEBUG
  print "$antismash_accession\n";
  #next unless $antismash_accession eq $debug; ########### debug
  #if($antismash_accession eq $debug) {die "$debug\n";}


  #warn "$accession\n";
  my $genecluster_file = "$antismash_batch_dir/$antismash_accession/svg/genecluster1.svg";

  if (-e $genecluster_file) { ##################################################################?

    my $cmd = "ls $antismash_batch_dir/$antismash_accession/svg/genecluster*";
    #warn "cmd = $cmd\n";

    my (@antismash_image_files) = `$cmd`;
  #if (@antismash_image_files) {
    chomp(@antismash_image_files);
    print "files = @antismash_image_files\n";

    my $num_files = @antismash_image_files;
    print "num files = $num_files\n";

    foreach my $x(@antismash_image_files) {
      #next; # WORKING!
      print "image file = $x\n";
      my $num_kss = get_num_domains($x, "KS");
      print "number of KS = $num_kss\n";
      print "minimum KS = $min_antismash_ks_num\n";
      next unless $num_kss >= $min_antismash_ks_num;
      $x =~ /.*\/(.*\.svg)/;
      my $filename = $1;
      $filename =~ /genecluster(\d+)\.svg/;
      my $clusternum = $1;
      # get cluster coords from js file
      # eg antismash2.6dbs.min3.pksnrps/NC_000962/geneclusters.js 
      my $js_file = "$antismash_batch_dir/$antismash_accession/geneclusters.js";
      #warn "js file = $js_file\n";
      my $coords = get_coords($js_file, $clusternum);
      print OUT "$antismash_accession\t$desc\t$clusternum\t$coords\n";
    }

    next;# get here ok.  Need to get this to stop working to figure out what's wrong.
  }
  else { # no image files, no results
    print OUTNORESULT "No files for $accession in $antismash_batch_dir/$antismash_accession/svg/genecluster1.svg\n";
    next;
  }

}


print  "\nOutput to $outfile and $no_results_outfile\n\n";
exit;


# Subroutines

sub get_coords {
  my $js_file = shift;
  my $clusternum = shift;
  my $grep_endline = "grep '\"cluster-$clusternum\"' --after-context=2 $js_file";
  my $grep_start_search = "awk 'f;/\"cluster-$clusternum\"/{f=1}' $js_file | grep knowncluster --after-context=2 -m 1";
  #awk 'f;/regexp/{f=1}' file
  print "\n$grep_start_search";
  #my $grep_search_actual_text = `$grep_start_search`;
  #print "\n$grep_search_actual_text";
  #my $grep_startline = "grep knowncluster --after-context=2 -m 1 $grep_search_actual_text";
  my $location_end_lines = `$grep_endline`;
  my $location_start_lines =`$grep_start_search`;
  #print "\n$location_start_lines\n";
  #print "\n$location_end_lines\n";
  $location_start_lines =~ /start\": (.*),/;
  my $start = $1;
  $location_end_lines =~ /end\": (.*),/;
  my $end = $1;
  #warn "start = '$start', end = '$end'\n";
  my $coords = "$start-$end";
  #my $coords = 1-20;
  return $coords;
}
  


sub get_num_domains {
  my $file = shift;
  my $domain = shift;
  my $grep_query = "$domain"."_domain";
  my $results = `grep $grep_query $file`;
  my @results = split("\n", $results);
  my %counts;
  foreach my $result (@results) {
    $result =~ /($grep_query\d+_\d+)/;
    $counts{$1} = 1;
  }
  return keys %counts;
}



sub build_hash_from_two_cols {
  my($file) = @_;
  open(TWOCOL, $file) || die "Can't open file $file\n";
  my %hash;
  while(<TWOCOL>) {
    chomp;
    my($first, $second, @rest) = split("\t", $_);
    $hash{$first} = $second;
  }
  return %hash;
}




sub print_hash{
  my(%hash) = @_;
  foreach my $key(sort keys %hash) {
    print "'$key'\t'$hash{$key}'\n";
  }
}

