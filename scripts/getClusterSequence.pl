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
use Bio::SeqIO;

die "Usage: $0 genbank_dir cluster_file antismash_dir\n" unless @ARGV >= 3;
my $genbank_dir = shift;
my $cluster_file = shift;
my $antismash_dir = shift;
my $sequence_error = "Error in sequence file";

open(IN, $cluster_file);
while(<IN>) {

  chomp;
  my($accession, $desc, $clusternum, $coords) = split("\t", $_);

  my $antismash_accession = $accession;
  if($accession =~ /(.*)\.\d+/) {
    $antismash_accession = $1;
  }
  my $local_antismash_image_file = "$antismash_dir/$antismash_accession/svg/genecluster$clusternum.svg";

  my($start, $stop) = split('-', $coords);
  my $length = $stop - $start;

  my ($gene_cluster_seq) = get_cluster_seq($accession, $coords);
  print "$accession\t$desc\t$clusternum\t$coords\t$gene_cluster_seq\n";
  
  # calculate gc content
  #unless ($gene_cluster_seq=~ /Error/) {
  #$gc = $gc *100;
  #$gc = sprintf("%.2f", $gc);
  #}
}
exit;

sub get_cluster_seq{
  my $gb = shift;
  my $coords = shift;
  my $file = "$genbank_dir/$gb.gb";
  my $format = "genbank";

  unless (-e $file) { die "Error, no file $file\n";}
  my $inseq = Bio::SeqIO->new(
                            -file   => "$file",
                            -format => $format,
                            );

  my $seqobj = $inseq->next_seq;
  my $seq = $seqobj->seq;
  my $total_length = $seqobj->length; 
  my($start, $stop) = split('-', $coords);
  my $len_start_stop = $stop - $start;
  my $cluster = substr($seq, $start, $len_start_stop);
  return $cluster;
}

#  my $len = length $cluster;
#  my $len_seq = length $seq;
#  my $gcount = ($cluster =~ tr/G//);
#  my $ccount = ($cluster =~ tr/C//);
#  my $gc_num = $gcount+$ccount;
#  my $gc = $gc_num / $len;
#  return ($gc, $total_length);
#}




