[![Build Status](https://travis-ci.org/tseemann/abricate.svg?branch=master)](https://travis-ci.org/tseemann/abricate) 
[![License: GPL v2](https://img.shields.io/badge/License-GPL%20v2-blue.svg)](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)
[![European Galaxy server](https://img.shields.io/badge/usegalaxy-.eu-brightgreen?logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAASCAYAAABB7B6eAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAACXBIWXMAAAsTAAALEwEAmpwYAAACC2lUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iWE1QIENvcmUgNS40LjAiPgogICA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPgogICAgICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgICAgICAgICB4bWxuczp0aWZmPSJodHRwOi8vbnMuYWRvYmUuY29tL3RpZmYvMS4wLyI+CiAgICAgICAgIDx0aWZmOlJlc29sdXRpb25Vbml0PjI8L3RpZmY6UmVzb2x1dGlvblVuaXQ+CiAgICAgICAgIDx0aWZmOkNvbXByZXNzaW9uPjE8L3RpZmY6Q29tcHJlc3Npb24+CiAgICAgICAgIDx0aWZmOk9yaWVudGF0aW9uPjE8L3RpZmY6T3JpZW50YXRpb24+CiAgICAgICAgIDx0aWZmOlBob3RvbWV0cmljSW50ZXJwcmV0YXRpb24+MjwvdGlmZjpQaG90b21ldHJpY0ludGVycHJldGF0aW9uPgogICAgICA8L3JkZjpEZXNjcmlwdGlvbj4KICAgPC9yZGY6UkRGPgo8L3g6eG1wbWV0YT4KD0UqkwAAAn9JREFUOBGlVEuLE0EQruqZiftwDz4QYT1IYM8eFkHFw/4HYX+GB3/B4l/YP+CP8OBNTwpCwFMQXAQPKtnsg5nJZpKdni6/6kzHvAYDFtRUT71f3UwAEbkLch9ogQxcBwRKMfAnM1/CBwgrbxkgPAYqlBOy1jfovlaPsEiWPROZmqmZKKzOYCJb/AbdYLso9/9B6GppBRqCrjSYYaquZq20EUKAzVpjo1FzWRDVrNay6C/HDxT92wXrAVCH3ASqq5VqEtv1WZ13Mdwf8LFyyKECNbgHHAObWhScf4Wnj9CbQpPzWYU3UFoX3qkhlG8AY2BTQt5/EA7qaEPQsgGLWied0A8VKrHAsCC1eJ6EFoUd1v6GoPOaRAtDPViUr/wPzkIFV9AaAZGtYB568VyJfijV+ZBzlVZJ3W7XHB2RESGe4opXIGzRTdjcAupOK09RA6kzr1NTrTj7V1ugM4VgPGWEw+e39CxO6JUw5XhhKihmaDacU2GiR0Ohcc4cZ+Kq3AjlEnEeRSazLs6/9b/kh4eTC+hngE3QQD7Yyclxsrf3cpxsPXn+cFdenF9aqlBXMXaDiEyfyfawBz2RqC/O9WF1ysacOpytlUSoqNrtfbS642+4D4CS9V3xb4u8P/ACI4O810efRu6KsC0QnjHJGaq4IOGUjWTo/YDZDB3xSIxcGyNlWcTucb4T3in/3IaueNrZyX0lGOrWndstOr+w21UlVFokILjJLFhPukbVY8OmwNQ3nZgNJNmKDccusSb4UIe+gtkI+9/bSLJDjqn763f5CQ5TLApmICkqwR0QnUPKZFIUnoozWcQuRbC0Km02knj0tPYx63furGs3x/iPnz83zJDVNtdP3QAAAABJRU5ErkJggg==)](https://usegalaxy.eu/root?tool_id=abricate)
![Don't judge me](https://img.shields.io/badge/Language-Perl_5-steelblue.svg)

# ABRicate

Mass screening of contigs for antimicrobial resistance or virulence genes.
It comes bundled with multiple databases: 
NCBI, CARD, ARG-ANNOT, Resfinder, MEGARES, EcOH, PlasmidFinder, Ecoli_VF and
VFDB.

## Is this the right tool for me?

1. It only supports contigs, not FASTQ reads
2. It only detects acquired resistance genes, **NOT** point mutations
3. It uses a DNA sequence database, not protein
4. It needs BLAST+ >= 2.7 and `any2fasta` to be installed
5. It's written in Perl :camel:

If you are happy with the above, then please continue!
Otherwise consider using
[Ariba](https://github.com/sanger-pathogens/ariba),
[Resfinder](https://cge.cbs.dtu.dk/services/ResFinder/),
[RGI](https://card.mcmaster.ca/analyze/rgi),
[SRST2](https://github.com/katholt/srst2),
[AMRFinderPlus](https://github.com/ncbi/amr#ncbi-antimicrobial-resistance-gene-finder-amrfinderplus),
*etc.*

## Quick Start

```
% abricate 6159.fasta
Using database resfinder:  2130 sequences -  Mar 17, 2017
Processing: 6159.fna
Found 3 genes in 6159.fna
#FILE     SEQUENCE     START   END     STRAND GENE     COVERAGE     COVERAGE_MAP     GAPS  %COVERAGE  %IDENTITY  DATABASE  ACCESSION  PRODUCT        RESISTANCE
6159.fna  NC_017338.1  39177   41186   +      mecA_15  1-2010/2010  ===============  0/0   100.00     100.000    ncbi      AB505628   n/a	     FUSIDIC_ACID
6159.fna  NC_017338.1  727191  728356  -      norA_1   1-1166/1167  ===============  0/0   99.91      92.367     ncbi      M97169     n/a            FOSFOMYCIN
6159.fna  NC_017339.1  10150   10995   +      blaZ_32  1-846/846    ===============  0/0   100.00     100.000    ncbi      AP004832   betalactamase  BETA-LACTAM;PENICILLIN
```

## Installation

### Brew
If you are using the [MacOS Homebrew](http://brew.sh/) or [LinuxBrew](http://brew.sh/linuxbrew/) packaging system:
```
brew install brewsci/bio/abricate
abricate --check
abricate --list
```

### Bioconda
If you use [Conda](https://conda.io/docs/install/quick.html) 
follow the instructions to add the [Bioconda channel](https://bioconda.github.io/):
```
conda install -c conda-forge -c bioconda -c defaults abricate
abricate --check
abricate --list
```

### Source
If you install from source, Abricate has the following package dependencies:
* `any2fasta` for sequence file format conversion
* BLAST+ >2.7.0 for `blastn`, `makeblastdb`, `blastdbcmd`
* Perl modules: `LWP::Simple`, `Bio::Perl`, `JSON`, `Path::Tiny`
* `git`, `unzip`, `gzip` for updating databases

Most of these are easy to install on an Ubuntu-based system:
```
sudo apt-get install bioperl ncbi-blast+ gzip unzip git \
  libjson-perl libtext-csv-perl libpath-tiny-perl liblwp-protocol-https-perl libwww-perl
git clone https://github.com/tseemann/abricate.git
./abricate/bin/abricate --check
./abricate/bin/abricate --setupdb
./abricate/bin/abricate ./abricate/test/assembly.fa
```

## Input

Abricate takes any sequence file that `any2fasta` can convert to FASTA files (eg. Genbank,
EMBL), and they can be optionally `gzip` or `bzip2` compressed.
```
abricate assembly.fa 
abricate assembly.fa.gz
abricate assembly.gbk 
abricate assembly.gbk.bz2
```

It can take multiple files at once too:
```
abricate assembly.*
abricate /mnt/ncbi/bacteria/*.gbk.gz 
```

Or you can provide it a "file of file names" (a "FOFN"):
```
% cat test/fofn.txt

assembly.fa
assembly.fa.gz
assembly.gbk
assembly.gbk.bz2

% abricate --fofn test/fofn.txt
```

It does not accept raw FASTQ reads; please use
[Ariba](https://github.com/sanger-pathogens/ariba) or
[SRTS2](https://github.com/katholt/srst2) for that.

## Output

Abricate produces a tap-separated output file with the following columns:

Column | Example | Description
-------|---------|------------
FILE | `Ecoli.fna` | The filename this hit came from
SEQUENCE | `contig000324` | The sequence in the filename
START | `23423` | Start coordinate in the sequence
END | `24117` | End coordinate
STRAND | `+` | Strand + or -
GENE | `tet(M)` | AMR gene name
COVERAGE | `1-1920/1920` | What proportion of the gene is in our sequence
COVERAGE_MAP | `===============` | A visual represenation of the hit. `=`=aligned, `.`=unaligned, `/`=has_gaps
GAPS | `1/4` | Openings / gaps in subject and query - possible psuedogene?
%COVERAGE | `100.00%` | Proportion of gene covered
%IDENTITY | `99.95%` | Proportion of exact nucleotide matches
DATABASE | `ncbi` | The database this sequence comes from
ACCESSION | `NC_009632:49744-50476` | The genomic source of the sequence
PRODUCT | `aminoglycoside O-phosphotransferase APH(3')-IIIa` | Gene product (if available)
RESISTANCE | `TETRACYCLINE;FUSIDIC_ACID` | putative antibiotic resistance phenotype, `;`-separated

## Caveats

* Does not find mutational resistance, only acquired genes.
* Gap reporting incomplete
* Sometimes two heavily overlapping genes will be reported for the same locus
* Possible coverage calculation issues

## Databases

ABRicate comes with some pre-downloaded databases:

* [NCBI AMRFinderPlus](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA313047)
* [CARD](https://card.mcmaster.ca/)
* [Resfinder](https://cge.cbs.dtu.dk/services/ResFinder/)
* [ARG-ANNOT](http://en.mediterranee-infection.com/article.php?laref=283%26titre=arg-annot)
* [MEGARES](https://megares.meglab.org/)
* [EcOH](https://github.com/katholt/srst2/tree/master/data)
* [PlasmidFinder](https://cge.cbs.dtu.dk/services/PlasmidFinder/)
* [VFDB](http://www.mgc.ac.cn/VFs/)
* [Ecoli_VF](https://github.com/phac-nml/ecoli_vf)

You can check what you have installed with the `--list` command.
This lists the available databases in TSV (or CSV with `--csv`) and three
columns:
```
% abricate --list

DATABASE       SEQUENCES  DBTYPE  DATE
argannot       1749       nucl    2019-Jul-28
card           2241       nucl    2019-Jul-28
ecoh           597        nucl    2019-Jul-28
ecoli_vf       2701       nucl    2019-Jul-28
megares        6635       nucl    2020-Feb-20
ncbi           4324       nucl    2019-Jul-28
plasmidfinder  263        nucl    2019-Jul-28
resfinder      2434       nucl    2019-Jul-28
vfdb           2597       nucl    2019-Jul-28
```

The default database is `ncbi`.
You can choose a different database using the `--db` option:
```
% abricate --db vfdb --quiet 6159.fa

6159.fna  NC_017338.1  2724620  2726149  aur      1-1530/1530     ===============  0/0    100.00     99.346     vfdb      NP_647375	zinc metalloproteinase aureolysin
6159.fna  NC_017338.1  2766595  2767155  icaR     1-561/561       ===============  0/0    100.00     98.930     vfdb      NP_647402	N-acetylglucosaminyltransferase
6159.fna  NC_017338.1  2767319  2768557  icaA     1-1239/1239     ===============  0/0    100.00     99.677     vfdb      NP_647403	n/a
6159.fna  NC_017338.1  2768521  2768826  icaD     1-306/306       ===============  0/0    100.00     99.020     vfdb      NP_647404	n/a
6159.fna  NC_017338.1  2768823  2769695  icaB     1-873/873       ===============  0/0    100.00     99.542     vfdb      NP_647405	n/a
6159.fna  NC_017338.1  2769682  2770734  icaC     1-1053/1053     ===============  0/0    100.00     98.955     vfdb      NP_647406	n/a
6159.fna  NC_017338.1  2771040  2773085  lip      1-2046/2046     ===============  0/0    100.00     98.778     vfdb      NP_647407	triacylglycerol lipase precursor
```

## Combining reports across samples

ABRicate can combine results into a simple matrix of gene presence/absence.
An absent gene is denoted `.` and a present gene is represented by its '%COVERAGE`.
This can be individual abricate reports, or a combined one.

```
# Run abricate on each .fa file
% abricate 1.fna > 1.tab
% abricate 2.fna > 2.tab

# Combine
% abricate --summary 1.tab 2.tab

#FILE     NUM_FOUND  aac(6')-aph(2'')_1  aadD_1  blaZ_32  blaZ_36  erm(A)_1  mecA_15  norA_1  spc_1  tet(M)_7
1.tab     8          100.00              100.00  .        100.00   100.00    100.00   99.91   100.00  100.00
2.tab     3          .                   .       100.00   .        .         100.00   99.91   .       .
```
Or if you ran everything in a single report, it will work too.
```
% abricate *.fna > results.tab
% abricate --summary results.tab > summary.tab
```

## Updating the databases

```
# force download of latest version
% abricate-get_db --db ncbi --force

# re-use existing download and just regenerate the database
% abricate-get_db --db ncbi
```

## Making your own database

Let's say you want to make your own database called `tinyamr`. 
All you need is a FASTA file of nucleotide sequences, say `tinyamr.fa`.
Ideally the sequence IDs would have the format `>DB~~~ID~~~ACC~~~RESISTANCES DESC`
where `DB` is `tinyamr`, `ID` is the gene name, `ACC` is an accession
number of the sequence source, `RESISTANCES` is the phenotype(s) to report,
and `DESC` can be any textual description.

```
% cd /path/to/abricate/db     # this is the --datadir default option
% mkdir tinyamr
% cp /path/to/tinyamr.fa sequences
% head -n 1 sequences
>tinyamr~~~GENE_ID~~~GENE_ACC~~RESISTANCES some description here
% abricate --setupdb
% # or just do this: makeblastdb -in sequences -title tinyamr -dbtype nucl -hash_index

% abricate --list
DATABASE  SEQUENCES  DBTYPE  DATE
tinyamr   173        nucl    2019-Aug-28

% abricate --db tinyamr screen_this.fasta
```

## Etymology

The name "ABRicate" was chosen as the first 3 letters are a common acronym
for "Anti-Biotic Resistance". It also has the form of an English _verb_, 
which suggests the tool actual taking "action" against the problem of antibiotic resistance.
It is also relatively unique in [Google](https://www.google.com.au/search?q=abricate),
and is unlikely to receive an infamous [JABBA Award](http://www.acgt.me/blog/2014/12/1/time-for-a-new-jabba-award-for-just-another-bogus-bioinformatics-acronym).

## Citation

If you publish the results of Abricate please cite both the software _and_
the appropriate database you used with `--db`

* Seemann T, *Abricate*, **Github** `https://github.com/tseemann/abricate`
* NCBI AMRFinderPlus - [doi: 10.1128/AAC.00483-19](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6811410)
* CARD - [doi:10.1093/nar/gkw1004](https://www.ncbi.nlm.nih.gov/pubmed/27789705)
* Resfinder - [doi:10.1093/jac/dks261](https://www.ncbi.nlm.nih.gov/pubmed/22782487)
* ARG-ANNOT - [doi:10.1128/AAC.01310-13](https://www.ncbi.nlm.nih.gov/pubmed/24145532)
* VFDB - [doi:10.1093/nar/gkv1239](https://www.ncbi.nlm.nih.gov/pubmed/26578559)
* PlasmidFinder - [doi:10.1128/AAC.02412-14](https://www.ncbi.nlm.nih.gov/pubmed/24777092)
* EcOH - [doi:10.1099/mgen.0.000064](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5343136/)
* MEGARES 2.00 - [doi:10.1093/nar/gkz1010](https://academic.oup.com/nar/article/48/D1/D561/5624973)
## Issues

Please report problems to the [Issues Page](https://github.com/tseemann/abricate/issues).

## License

[GPLv2](https://raw.githubusercontent.com/tseemann/abricate/master/LICENSE)

## Author

Torsten Seemann | [@torstenseemann](https://twitter.com/torstenseemann) | [blog](http://thegenomefactory.blogspot.com/)
