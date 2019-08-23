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

use Bio::SeqIO;

die "Usage:  $0 infile seqdir outdir \n" unless @ARGV >= 3;

my $infile = shift;
my $sequence_dir = shift;
my $outdir = shift;


if (-e $outdir) {
  die "$outdir exists, exiting...\n";
}
`mkdir $outdir`;

my @clusters = build_array_from_list($infile);

foreach my $cluster(@clusters){
  my($genbankid1, $desc1, $date1, $species1, $clusterstring1, $url1, $coords1) = split("\t", $cluster);
  $clusterstring1 =~ /Cluster (.*)/;
  my $clusternum1 = $1 || "0";
  #next unless $genbankid1 =~ /AM420293/; #debug
  my $file1 = "$sequence_dir/$genbankid1/$genbankid1.fasta";
  unless (-e $file1) {print "Missing file $file1\n";} #Skip missing fasta files?

  my $outfile = "$outdir/$genbankid1.$clusternum1.fasta";
  if (-e $outfile) { 
    print "outfile $outfile already exists, skipping...\n";
    exit; 
  }

  # Extract sequence
  my $in  = Bio::SeqIO->new(-file => $file1,
                           -format => 'fasta');

  my $inseq = $in->next_seq;
  my $seq = $inseq->seq;
  my $acc = $inseq->accession_number;
  my $desc = $inseq->desc;

  #print "seq = $seq\n";
  my $newseq = $inseq;

  # Extract subset of sequence
  my($start, $end) = split('-', $coords1);
  print "$genbankid1\n";
  print "$start\n";
  print "$end\n";
  # test
  #$start = 1;
  #$end = 10;

  my $subseq = $inseq->subseq($start, $end);
  $newseq->seq($subseq);
  my $length = length $subseq;

  # Change description
  my $newdesc = $desc . " Coords " . $start . "-" . $end . ", Length $length";
  $newseq->desc($newdesc);

  my $out = Bio::SeqIO->new(-file => ">$outfile" ,
                            -format => 'Fasta');

  $out->write_seq($newseq);

  #last; # DEBUG

}


exit;





sub build_array_from_list {
  my($file) = @_;
  open(BUILDARRAY, $file) || warn "$file doesn't exist in build_array_from_list\n";
  my $header = <BUILDARRAY>;
  my (@names) = <BUILDARRAY>;
  chomp(@names);
  return @names;
}

