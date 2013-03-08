#!/usr/bin/env perl
use strict;
use warnings;

BEGIN { unshift(@INC, './lib') }
BEGIN {
    use Test::Most;
    use Bio::MLST::CompareAlleles;
    use Bio::MLST::SequenceType;
    use_ok('Bio::MLST::Spreadsheet::Row');
}

my $compare_alleles = Bio::MLST::CompareAlleles->new(
  sequence_filename => 't/data/contigs.fa',
  allele_filenames  => ['t/data/adk.tfa','t/data/purA.tfa','t/data/recA.tfa'],
  profiles_filename => 't/data/Escherichia_coli_1/profiles/escherichia_coli.txt',
);
my $sequence_type_obj = Bio::MLST::SequenceType->new(
  profiles_filename => 't/data/Escherichia_coli_1/profiles/escherichia_coli.txt',
  sequence_names    => $compare_alleles->found_sequence_names
);


ok((my $spreadsheet_row_obj = Bio::MLST::Spreadsheet::Row->new(sequence_type_obj => $sequence_type_obj, compare_alleles => $compare_alleles)),'create a valid spreadsheet row obj');
is_deeply($spreadsheet_row_obj->allele_numbers_row, ['contigs', 4,'','',2,3,1], 'valid allele_number row');
is_deeply($spreadsheet_row_obj->genomic_row, ['contigs', 4,'','','GGGGAAAGGGACTCAGGCTCAGTTCATCATGGAGAAATATGGTATTCCGCAAATCTCCACTGGCGATATGCTGCGTGCTGCGGTCAAATCTGGCTCCGAGCTGGGTAAACAAGCAAAAGACATTATGGATGCTGGCAAACTGGTTACCGACGAACTGGTGATCGCGCTGGTTAAAGGGCGCATTGCTCAGGAAGACTGCCGTAATGGTTTCCTGTTGGACGGCTTCCCGCGTACCATTCCGCAGGCAGACGCGATGAAAGAAGCGGGCATCAATGTTGATTACGTTCTGGAATTCGACGTACCGGACGAACTGATCGTTGACCGTATCGTCGGTCGCCGCGTTCACGCGCCGTCTGGTCGTGTTTATCACGTTAAATTCAATCCGCCGAAAGTAGAAGGTAAAGACGACGTTACCGGTGAAGAACTGACTACCCGTAAAGACGATCAGGAAGAAACCGTACGTAAACGTCTGGTTGAATACCATCAGATGACAGCACCGCTGATCGGCTACTACTCCAAAGAAGCTGAAGCGGGTA',
'ATAACGCGCGTGAGAAAGCGCGTGGCGCGAAAGCGATCGGCACCACCGGTCGTGGTATCGGGCCTGCTTATGAAGATAAAGTGGCACGTCGCGGTCTGCGTGTTGGCGACCTTTTCGACAAAGAAACCTTCGCTGAAAAACTGAAAGAAGTGATGGAATATCACAACTTCCAGTTGGTTAACTACTACAAAGCTGAAGCGGTTGATTACCAGAAAGTTCTGGATGATACGATGGCTGTTGCCGACATCCTGACTTCTATGGTGGTTGACGTTTCTGACCTGCTCGACCAGGCGCGTCAGCGTGGCGATTTCGTCATGTTCGAAGGTGCGCAGGGTACGCTGCTGGATATCGACCACGGTACTTATCCGTACGTAACTTCTTCCAACACCACTGCTGGTGGCGTGGCGACCGGTTCCGGCCTGGGCCCGCGTTATGTTGATTACGTTCTGGGTATCCTCAAAGCTTACTCAACTCGTGT',
'CGCACGTAAACTGGGCGTCGATATCGACAACCTGCTGTGCTCCCAGCCGGACACCGGCGAGCAGGCACTGGAAATCTGTGACGCCCTGGCGCGTTCTGGTGCAGTAGACGTTATCGTCGTTGACTCCGTGGCGGCACTGACGCCGAAAGCGGAAATCGAAGGCGAAATCGGCGACTCTCACATGGGCCTTGCGGCACGTATGATGAGCCAGGCGATGCGTAAGCTGGCGGGTAACCTGAAGCAGTCCAACACGCTGCTGATCTTCATCAACCAGATCCGTATGAAAATTGGTGTGATGTTCGGTAACCCGGAAACCACTACCGGTGGTAACGCGCTGAAATTCTACGCCTCTGTTCGTCTCGACATCCGTCGTATCGGCGCGGTGAAAGAGGGCGAAAACGTGGTGGGTAGCGAAACCCGCGTGAAAGTGGTGAAGAACAAAATCGCTGCACCGTTTAAACAGGCTGAATTTCAGATCCTCTACGGCGAAGGTATCAACTTCTACGGCGA'],
 'valid genomic row');
 

$compare_alleles->contamination(1);
ok(($spreadsheet_row_obj = Bio::MLST::Spreadsheet::Row->new(sequence_type_obj => $sequence_type_obj, compare_alleles => $compare_alleles)),'create a valid spreadsheet row obj contamination');
is_deeply($spreadsheet_row_obj->allele_numbers_row, ['contigs', 4,'','Contamination',2,3,1], 'valid allele_number row contamination');
is_deeply($spreadsheet_row_obj->genomic_row, ['contigs', 4,'','Contamination','GGGGAAAGGGACTCAGGCTCAGTTCATCATGGAGAAATATGGTATTCCGCAAATCTCCACTGGCGATATGCTGCGTGCTGCGGTCAAATCTGGCTCCGAGCTGGGTAAACAAGCAAAAGACATTATGGATGCTGGCAAACTGGTTACCGACGAACTGGTGATCGCGCTGGTTAAAGGGCGCATTGCTCAGGAAGACTGCCGTAATGGTTTCCTGTTGGACGGCTTCCCGCGTACCATTCCGCAGGCAGACGCGATGAAAGAAGCGGGCATCAATGTTGATTACGTTCTGGAATTCGACGTACCGGACGAACTGATCGTTGACCGTATCGTCGGTCGCCGCGTTCACGCGCCGTCTGGTCGTGTTTATCACGTTAAATTCAATCCGCCGAAAGTAGAAGGTAAAGACGACGTTACCGGTGAAGAACTGACTACCCGTAAAGACGATCAGGAAGAAACCGTACGTAAACGTCTGGTTGAATACCATCAGATGACAGCACCGCTGATCGGCTACTACTCCAAAGAAGCTGAAGCGGGTA',
'ATAACGCGCGTGAGAAAGCGCGTGGCGCGAAAGCGATCGGCACCACCGGTCGTGGTATCGGGCCTGCTTATGAAGATAAAGTGGCACGTCGCGGTCTGCGTGTTGGCGACCTTTTCGACAAAGAAACCTTCGCTGAAAAACTGAAAGAAGTGATGGAATATCACAACTTCCAGTTGGTTAACTACTACAAAGCTGAAGCGGTTGATTACCAGAAAGTTCTGGATGATACGATGGCTGTTGCCGACATCCTGACTTCTATGGTGGTTGACGTTTCTGACCTGCTCGACCAGGCGCGTCAGCGTGGCGATTTCGTCATGTTCGAAGGTGCGCAGGGTACGCTGCTGGATATCGACCACGGTACTTATCCGTACGTAACTTCTTCCAACACCACTGCTGGTGGCGTGGCGACCGGTTCCGGCCTGGGCCCGCGTTATGTTGATTACGTTCTGGGTATCCTCAAAGCTTACTCAACTCGTGT',
'CGCACGTAAACTGGGCGTCGATATCGACAACCTGCTGTGCTCCCAGCCGGACACCGGCGAGCAGGCACTGGAAATCTGTGACGCCCTGGCGCGTTCTGGTGCAGTAGACGTTATCGTCGTTGACTCCGTGGCGGCACTGACGCCGAAAGCGGAAATCGAAGGCGAAATCGGCGACTCTCACATGGGCCTTGCGGCACGTATGATGAGCCAGGCGATGCGTAAGCTGGCGGGTAACCTGAAGCAGTCCAACACGCTGCTGATCTTCATCAACCAGATCCGTATGAAAATTGGTGTGATGTTCGGTAACCCGGAAACCACTACCGGTGGTAACGCGCTGAAATTCTACGCCTCTGTTCGTCTCGACATCCGTCGTATCGGCGCGGTGAAAGAGGGCGAAAACGTGGTGGGTAGCGAAACCCGCGTGAAAGTGGTGAAGAACAAAATCGCTGCACCGTTTAAACAGGCTGAATTTCAGATCCTCTACGGCGAAGGTATCAACTTCTACGGCGA'],
 'valid genomic row contamination');
$compare_alleles->contamination(0);

$compare_alleles->new_st(1);
ok(($spreadsheet_row_obj = Bio::MLST::Spreadsheet::Row->new(sequence_type_obj => $sequence_type_obj, compare_alleles => $compare_alleles)),'create a valid spreadsheet row obj new ST');
is_deeply($spreadsheet_row_obj->allele_numbers_row, ['contigs', 4,'Unknown','',2,3,1], 'valid allele_number row new ST');
is_deeply($spreadsheet_row_obj->genomic_row, ['contigs', 4,'Unknown','','GGGGAAAGGGACTCAGGCTCAGTTCATCATGGAGAAATATGGTATTCCGCAAATCTCCACTGGCGATATGCTGCGTGCTGCGGTCAAATCTGGCTCCGAGCTGGGTAAACAAGCAAAAGACATTATGGATGCTGGCAAACTGGTTACCGACGAACTGGTGATCGCGCTGGTTAAAGGGCGCATTGCTCAGGAAGACTGCCGTAATGGTTTCCTGTTGGACGGCTTCCCGCGTACCATTCCGCAGGCAGACGCGATGAAAGAAGCGGGCATCAATGTTGATTACGTTCTGGAATTCGACGTACCGGACGAACTGATCGTTGACCGTATCGTCGGTCGCCGCGTTCACGCGCCGTCTGGTCGTGTTTATCACGTTAAATTCAATCCGCCGAAAGTAGAAGGTAAAGACGACGTTACCGGTGAAGAACTGACTACCCGTAAAGACGATCAGGAAGAAACCGTACGTAAACGTCTGGTTGAATACCATCAGATGACAGCACCGCTGATCGGCTACTACTCCAAAGAAGCTGAAGCGGGTA',
'ATAACGCGCGTGAGAAAGCGCGTGGCGCGAAAGCGATCGGCACCACCGGTCGTGGTATCGGGCCTGCTTATGAAGATAAAGTGGCACGTCGCGGTCTGCGTGTTGGCGACCTTTTCGACAAAGAAACCTTCGCTGAAAAACTGAAAGAAGTGATGGAATATCACAACTTCCAGTTGGTTAACTACTACAAAGCTGAAGCGGTTGATTACCAGAAAGTTCTGGATGATACGATGGCTGTTGCCGACATCCTGACTTCTATGGTGGTTGACGTTTCTGACCTGCTCGACCAGGCGCGTCAGCGTGGCGATTTCGTCATGTTCGAAGGTGCGCAGGGTACGCTGCTGGATATCGACCACGGTACTTATCCGTACGTAACTTCTTCCAACACCACTGCTGGTGGCGTGGCGACCGGTTCCGGCCTGGGCCCGCGTTATGTTGATTACGTTCTGGGTATCCTCAAAGCTTACTCAACTCGTGT',
'CGCACGTAAACTGGGCGTCGATATCGACAACCTGCTGTGCTCCCAGCCGGACACCGGCGAGCAGGCACTGGAAATCTGTGACGCCCTGGCGCGTTCTGGTGCAGTAGACGTTATCGTCGTTGACTCCGTGGCGGCACTGACGCCGAAAGCGGAAATCGAAGGCGAAATCGGCGACTCTCACATGGGCCTTGCGGCACGTATGATGAGCCAGGCGATGCGTAAGCTGGCGGGTAACCTGAAGCAGTCCAACACGCTGCTGATCTTCATCAACCAGATCCGTATGAAAATTGGTGTGATGTTCGGTAACCCGGAAACCACTACCGGTGGTAACGCGCTGAAATTCTACGCCTCTGTTCGTCTCGACATCCGTCGTATCGGCGCGGTGAAAGAGGGCGAAAACGTGGTGGGTAGCGAAACCCGCGTGAAAGTGGTGAAGAACAAAATCGCTGCACCGTTTAAACAGGCTGAATTTCAGATCCTCTACGGCGAAGGTATCAACTTCTACGGCGA'],
 'valid genomic row new ST');
$compare_alleles->new_st(0);

# no match for adk
$compare_alleles = Bio::MLST::CompareAlleles->new(
  sequence_filename => 't/data/contigs.fa',
  allele_filenames  => ['t/data/adk_less_than_95_percent.tfa','t/data/purA.tfa','t/data/recA.tfa'],
  profiles_filename => 't/data/Escherichia_coli_1/profiles/escherichia_coli.txt',
);
$sequence_type_obj = Bio::MLST::SequenceType->new(
  profiles_filename => 't/data/Escherichia_coli_1/profiles/escherichia_coli.txt',
  sequence_names    => $compare_alleles->found_sequence_names
);
ok(($spreadsheet_row_obj = Bio::MLST::Spreadsheet::Row->new(sequence_type_obj => $sequence_type_obj, compare_alleles => $compare_alleles)),'create a valid spreadsheet row obj no hit for adk');
is_deeply($spreadsheet_row_obj->allele_numbers_row, ['contigs', 4,'Unknown','','U',3,1], 'no hit for adk');
is_deeply($spreadsheet_row_obj->genomic_row, ['contigs', 4,'Unknown','','U',
'ATAACGCGCGTGAGAAAGCGCGTGGCGCGAAAGCGATCGGCACCACCGGTCGTGGTATCGGGCCTGCTTATGAAGATAAAGTGGCACGTCGCGGTCTGCGTGTTGGCGACCTTTTCGACAAAGAAACCTTCGCTGAAAAACTGAAAGAAGTGATGGAATATCACAACTTCCAGTTGGTTAACTACTACAAAGCTGAAGCGGTTGATTACCAGAAAGTTCTGGATGATACGATGGCTGTTGCCGACATCCTGACTTCTATGGTGGTTGACGTTTCTGACCTGCTCGACCAGGCGCGTCAGCGTGGCGATTTCGTCATGTTCGAAGGTGCGCAGGGTACGCTGCTGGATATCGACCACGGTACTTATCCGTACGTAACTTCTTCCAACACCACTGCTGGTGGCGTGGCGACCGGTTCCGGCCTGGGCCCGCGTTATGTTGATTACGTTCTGGGTATCCTCAAAGCTTACTCAACTCGTGT',
'CGCACGTAAACTGGGCGTCGATATCGACAACCTGCTGTGCTCCCAGCCGGACACCGGCGAGCAGGCACTGGAAATCTGTGACGCCCTGGCGCGTTCTGGTGCAGTAGACGTTATCGTCGTTGACTCCGTGGCGGCACTGACGCCGAAAGCGGAAATCGAAGGCGAAATCGGCGACTCTCACATGGGCCTTGCGGCACGTATGATGAGCCAGGCGATGCGTAAGCTGGCGGGTAACCTGAAGCAGTCCAACACGCTGCTGATCTTCATCAACCAGATCCGTATGAAAATTGGTGTGATGTTCGGTAACCCGGAAACCACTACCGGTGGTAACGCGCTGAAATTCTACGCCTCTGTTCGTCTCGACATCCGTCGTATCGGCGCGGTGAAAGAGGGCGAAAACGTGGTGGGTAGCGAAACCCGCGTGAAAGTGGTGAAGAACAAAATCGCTGCACCGTTTAAACAGGCTGAATTTCAGATCCTCTACGGCGAAGGTATCAACTTCTACGGCGA'],
 'genomic no hit for adk');

# near match
$compare_alleles = Bio::MLST::CompareAlleles->new(
  sequence_filename => 't/data/contigs.fa',
  allele_filenames  => ['t/data/adk_contamination.tfa','t/data/purA.tfa','t/data/recA.tfa'],
  profiles_filename => 't/data/Escherichia_coli_1/profiles/escherichia_coli.txt',
);
$sequence_type_obj = Bio::MLST::SequenceType->new(
  profiles_filename => 't/data/Escherichia_coli_1/profiles/escherichia_coli.txt',
  sequence_names    => $compare_alleles->found_sequence_names
);
ok(($spreadsheet_row_obj = Bio::MLST::Spreadsheet::Row->new(sequence_type_obj => $sequence_type_obj, compare_alleles => $compare_alleles)),'create a valid spreadsheet row obj with contamination');
is_deeply($spreadsheet_row_obj->allele_numbers_row, ['contigs', 4,'Novel ST','Contamination',3,3,1], 'valid allele_number row with contamination');
is_deeply($spreadsheet_row_obj->genomic_row, ['contigs', 4,'Novel ST','Contamination','GGGGAAAGGGACTCAGGCTCAGTTCATCATGGAGAAATATGGTATTCCGCAAATCTCCACTGGCGATATGCTGCGTGCTGCGGTCAAATCTGGCTCCGAGCTGGGTAAACAAGCAAAAGACATTATGGATGCTGGCAAACTGGTTACCGACGAACTGGTGATCGCGCTGGTTAAAGGGCGCATTGCTCAGGAAGACTGCCGTAATGGTTTCCTGTTGGACGGCTTCCCGCGTACCATTCCGCAGGCAGACGCGATGAAAGAAGCGGGCATCAATGTTGATTACGTTCTGGAATTCGACGTACCGGACGAACTGATCGTTGACCGTATCGTCGGTCGCCGCGTTCACGCGCCGTCTGGTCGTGTTTATCACGTTAAATTCAATCCGCCGAAAGTAGAAGGTAAAGACGACGTTACCGGTGAAGAACTGACTACCCGTAAAGACGATCAGGAAGAAACCGTACGTAAACGTCTGGTTGAATACCATCAGATGACAGCACCGCTGATCGGCTACTACTCCAAAGAAGCTGAAGCGGGTA',
'ATAACGCGCGTGAGAAAGCGCGTGGCGCGAAAGCGATCGGCACCACCGGTCGTGGTATCGGGCCTGCTTATGAAGATAAAGTGGCACGTCGCGGTCTGCGTGTTGGCGACCTTTTCGACAAAGAAACCTTCGCTGAAAAACTGAAAGAAGTGATGGAATATCACAACTTCCAGTTGGTTAACTACTACAAAGCTGAAGCGGTTGATTACCAGAAAGTTCTGGATGATACGATGGCTGTTGCCGACATCCTGACTTCTATGGTGGTTGACGTTTCTGACCTGCTCGACCAGGCGCGTCAGCGTGGCGATTTCGTCATGTTCGAAGGTGCGCAGGGTACGCTGCTGGATATCGACCACGGTACTTATCCGTACGTAACTTCTTCCAACACCACTGCTGGTGGCGTGGCGACCGGTTCCGGCCTGGGCCCGCGTTATGTTGATTACGTTCTGGGTATCCTCAAAGCTTACTCAACTCGTGT',
'CGCACGTAAACTGGGCGTCGATATCGACAACCTGCTGTGCTCCCAGCCGGACACCGGCGAGCAGGCACTGGAAATCTGTGACGCCCTGGCGCGTTCTGGTGCAGTAGACGTTATCGTCGTTGACTCCGTGGCGGCACTGACGCCGAAAGCGGAAATCGAAGGCGAAATCGGCGACTCTCACATGGGCCTTGCGGCACGTATGATGAGCCAGGCGATGCGTAAGCTGGCGGGTAACCTGAAGCAGTCCAACACGCTGCTGATCTTCATCAACCAGATCCGTATGAAAATTGGTGTGATGTTCGGTAACCCGGAAACCACTACCGGTGGTAACGCGCTGAAATTCTACGCCTCTGTTCGTCTCGACATCCGTCGTATCGGCGCGGTGAAAGAGGGCGAAAACGTGGTGGGTAGCGAAACCCGCGTGAAAGTGGTGAAGAACAAAATCGCTGCACCGTTTAAACAGGCTGAATTTCAGATCCTCTACGGCGAAGGTATCAACTTCTACGGCGA'],
 'valid genomic row with contamination');
 
$compare_alleles = Bio::MLST::CompareAlleles->new(
   sequence_filename => 't/data/contigs_novel.fa',
     allele_filenames  => ['t/data/adk.tfa','t/data/purA.tfa','t/data/recA.tfa'],
     profiles_filename => 't/data/Escherichia_coli_1/profiles/escherichia_coli.txt',
);
$sequence_type_obj = Bio::MLST::SequenceType->new(
   profiles_filename => 't/data/Escherichia_coli_1/profiles/escherichia_coli.txt',
   sequence_names    => $compare_alleles->found_sequence_names
);
ok(($spreadsheet_row_obj = Bio::MLST::Spreadsheet::Row->new(sequence_type_obj => $sequence_type_obj, compare_alleles => $compare_alleles)),'create a valid spreadsheet with a novel ST');
is_deeply($spreadsheet_row_obj->allele_numbers_row, ['contigs_novel', 4,'Novel ST','',3,3,1], 'valid allele_number row with novel');
is_deeply($spreadsheet_row_obj->genomic_row, ['contigs_novel', 4,'Novel ST','','GGGGAAAGGGACTCAGGCTCAGTTCATCATGGAGAAATATGGTATTCCGCAAATCTCCACTGGCGATATGCTGCGTGCTGCGGTCAAATCTGGCTCCGAGCTGGGTAAACAAGCAAAAGACATTATGGATGCTGGCAAACTGGTCACCGACGAACTGGTGATCGCGCTGGTTAAAGAGCGCATTGCTCAGGAAGACTGCCGTAATGGTTTCCTGTTGGACGGCTTCCCGCGTACCATTCCGCAGGCAGACGCGATGAAAGAAGCGGGCATCAATGTTGATTACGTTCTGGAATTCGACGTACCGGACGAACTGATTGTTGATCGTATCGTAGGCCGCCGCGTTCATGCGCCGTCTGGTCGTGTTTATCACGTTAAATTCAATCCGCCGAAAGTAGAAGGCAAAGACGACGTTACCGGTGAAGAACTGACTACCCGTAAAGACGATCAGGAAGAAACCGTGCGTAAACGTCTGGTTGAATACCATCAGATGACTGCACCGTTGATCGGCTACTACTCCAAAGAAGCGGAAGCGGGTA',
 'ATAACGCGCGTGAGAAAGCGCGTGGCGCGAAAGCGATCGGCACCACCGGTCGTGGTATCGGGCCTGCTTATGAAGATAAAGTGGCACGTCGCGGTCTGCGTGTTGGCGACCTTTTCGACAAAGAAACCTTCGCTGAAAAACTGAAAGAAGTGATGGAATATCACAACTTCCAGTTGGTTAACTACTACAAAGCTGAAGCGGTTGATTACCAGAAAGTTCTGGATGATACGATGGCTGTTGCCGACATCCTGACTTCTATGGTGGTTGACGTTTCTGACCTGCTCGACCAGGCGCGTCAGCGTGGCGATTTCGTCATGTTCGAAGGTGCGCAGGGTACGCTGCTGGATATCGACCACGGTACTTATCCGTACGTAACTTCTTCCAACACCACTGCTGGTGGCGTGGCGACCGGTTCCGGCCTGGGCCCGCGTTATGTTGATTACGTTCTGGGTATCCTCAAAGCTTACTCAACTCGTGT',
 'CGCACGTAAACTGGGCGTCGATATCGACAACCTGCTGTGCTCCCAGCCGGACACCGGCGAGCAGGCACTGGAAATCTGTGACGCCCTGGCGCGTTCTGGTGCAGTAGACGTTATCGTCGTTGACTCCGTGGCGGCACTGACGCCGAAAGCGGAAATCGAAGGCGAAATCGGCGACTCTCACATGGGCCTTGCGGCACGTATGATGAGCCAGGCGATGCGTAAGCTGGCGGGTAACCTGAAGCAGTCCAACACGCTGCTGATCTTCATCAACCAGATCCGTATGAAAATTGGTGTGATGTTCGGTAACCCGGAAACCACTACCGGTGGTAACGCGCTGAAATTCTACGCCTCTGTTCGTCTCGACATCCGTCGTATCGGCGCGGTGAAAGAGGGCGAAAACGTGGTGGGTAGCGAAACCCGCGTGAAAGTGGTGAAGAACAAAATCGCTGCACCGTTTAAACAGGCTGAATTTCAGATCCTCTACGGCGAAGGTATCAACTTCTACGGCGA'],
  'valid genomic row with novel');
 

done_testing();
