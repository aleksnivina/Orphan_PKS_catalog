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

die "Usage: $0 infile\n" unless @ARGV >= 1;

my $infile = shift;


  open(IN, $infile) || die "Can't open file $infile\n";
  while (<IN>) {
    chomp;
    my($genbank, $desc, @rest) = split("\t", $_);
    #unless($genbank =~ /.*\|(.*)\|(.*)/) {
      #die "Error, not two pipes in $genbank\n";
    #}
    #$genbank =~ s/ref//g;
    #$genbank =~ s/dbj//g;
    #$genbank =~ s/emb//g;
    #$genbank =~ s/gb//g;
    #$genbank =~ s/tpe//g;
    #$genbank =~ s/\|//g;
    #print "$genbank\t$desc\n";
    print "$genbank\t$desc\n";

    # Some lines have a second accession... print these
    if($2) { print "$2\t$desc\n";}
  }
  close(IN);




