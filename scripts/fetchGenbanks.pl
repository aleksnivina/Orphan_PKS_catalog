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

# genbank id types accepted:
# ref, dbj, emb, gb, tpe

use strict;

use Bio::DB::EUtilities;

die "Usage: $0 infile seqFormat\n" unless @ARGV > 1;

my $infile = shift @ARGV;
my $seqFormat= shift @ARGV;
#my $rettype = 'gb';
#my $rettype = 'fasta';


my @idsAll = getGenbankIds($infile);
#warn "idsAll = @idsAll\n";
#exit;
my $numIds = @idsAll;
warn "Num of ids = $numIds\n";
warn "ids = @idsAll\n";
#my @ids = ($idsAll[0], $idsAll[1]);
#my @ids = ("392976478", "AC_000149.1", "NC_000017.10"); 
#my (@ids) = "AC_000149.1";
#my (@ids) = $id;

my $factory = Bio::DB::EUtilities->new(-eutil   => 'efetch',
                                       -db      => 'nucleotide',
                                       -rettype => $seqFormat,
                                       -email   => 'jakehsu@stanford.edu',
                                       -id      => \@idsAll);

#my $outfile = "$seqFolder/all.$seqFormat";
my $outfile = "$infile.$seqFormat";

# dump HTTP::Response content to a file (not retained in memory)
$factory->get_Response(-file => $outfile);
 
exit;



sub getGenbankIds {
  my $file = shift;
  open(IN, $file);
  my %genbankIds = ();
  while(<IN>) {
    chomp;
    my($genbank, @rest) = split("\t", $_);

    if($genbank =~ /(.*\|.*\|).*/) {
      $genbank = $1;
    }

    $genbank =~ s/ref//g;
    $genbank =~ s/dbj//g;
    $genbank =~ s/emb//g;
    $genbank =~ s/gb//g;
    $genbank =~ s/tpe//g;
    $genbank =~ s/\|//g;
    $genbankIds{$genbank} = 1;
  }
  close(IN);
  return sort keys %genbankIds;
}

