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

my $folder = shift;
my $format = "genbank";
 
my @files = `ls $folder/*gb`;
chomp(@files);
foreach my $file(@files){
  #print "file = $file\n";

  my $inseq = Bio::SeqIO->new(
                            -file   => "$file",
                            -format => $format,
                            );

  my $seq = $inseq->next_seq;
  my $accession = $seq->accession_number;
  

  $file =~ /$folder\/(.*)\.gb/;
  my $filename = $1 || warn "warning, no filename for $file\n";
  #warn $seq->accession_number, "\n";
  unless ($accession eq $filename) {
    warn "warning, filename $filename ne accession $accession...\n";
  }

  print "$filename";
  my (@dates) =  $seq->get_dates;
  foreach my $date(@dates) {
    print "\t$date";
  }

  my $anno_collection = $seq->annotation; 
  my @annotations = $anno_collection->get_Annotations('reference');
  for my $value ( @annotations ) {
    my $hash_ref = $value->hash_tree;
    for my $key (keys %{$hash_ref}) {
      next unless $key eq 'location';
      my $location = $hash_ref->{$key};
      if($location =~ /(\d{2}-\D{3}-\d{4})/) { # Find date-formatted parts of this reference location
        print "\t$1";
      }
    }
  }
  print "\n";
}


