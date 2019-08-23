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
#
use strict;
use Bio::SeqIO;

die "Usage $0 genbank fasta\n" unless @ARGV >= 2;

my $genbank_file = shift;
my $fasta_file = shift;

print_fasta($genbank_file, $fasta_file);

sub print_fasta {
  my $genbank_file = shift;
  my $fasta_file = shift;

  my $in  = Bio::SeqIO->new(-file => $genbank_file ,
                           -format => 'genbank');
  my $out = Bio::SeqIO->new(-file => ">$fasta_file" ,
                           -format => 'Fasta');

  my $seq = $in->next_seq();
  $out->write_seq($seq);
}

