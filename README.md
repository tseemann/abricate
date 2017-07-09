
# ABRicate

Mass screening of contigs for antimicrobial resistance or virulence genes.
It comes bundled with *six* databases: 
Resfinder, CARD, ARG-ANNOT, NCBI, PlasmidFinder and VFDB.


## Is this the right tool for me?

1. It only supports contigs, not FASTQ reads (including Genbank and .gz compressed files)
2. It only detects acquired resistance genes, not point mutations
3. It needs BLAST+ >= 2.2.30 and EMBOSS to be installed
4. It's written in Perl

If you are happy with the above, then please continue!

## Quick Start

```
% abricate 6159.fasta
Using database resfinder:  2130 sequences -  Mar 17, 2017
Processing: 6159.fna
Found 3 genes in 6159.fna
#FILE     SEQUENCE     START   END     GENE     COVERAGE     COVERAGE_MAP     GAPS  %COVERAGE  %IDENTITY  DATABASE   ACCESSION
6159.fna  NC_017338.1  39177   41186   mecA_15  1-2010/2010  ===============  0/0   100.00     100.000    resfinder  AB505628
6159.fna  NC_017338.1  727191  728356  norA_1   1-1166/1167  ===============  0/0   99.91      92.367     resfinder  M97169
6159.fna  NC_017339.1  10150   10995   blaZ_32  1-846/846    ===============  0/0   100.00     100.000    resfinder  AP004832
```

## Installation

### Brew
If you are using the [OSX Brew](http://brew.sh/) or [LinuxBrew](http://brew.sh/linuxbrew/) packaging system:
```
brew tap homebrew/science
brew tap tseemann/bioinformatics-linux
brew install abricate --HEAD
```

### Bioconda
If you use [Conda](https://conda.io/docs/install/quick.html) 
follow the instructions to add the [Bioconda channel](https://bioconda.github.io/):
```
conda install abricate
```

### Source
You will also need to install these dependencies manually:
* BLAST+ for `blastn` and `makeblastdb`
* EMBOSS for `seqret`
* Decompression tools `gzip` and `unzip`
Then install directly from github:
```
git clone https://github.com/tseemann/abricate.git
./abricate/bin/abricate --help
```

## Input

Abricate takes any sequence file that EMBOSS `seqret` can convert to FASTA files (eg. Genbank,
EMBL), and they can be optionally `gzip` compressed. It can take multiple files at once too.
```
abricate assembly.fa 
abricate assembly.fa.gz
abricate assembly.gbk 
abricate assembly.gbk.gz
```
It does not accept raw FASTQ reads; please see 
[Ariba](https://github.com/sanger-pathogens/ariba) or
[SRTS2](https://github.com/katholt/srst2) for that.

## Output

Abricate produces a tap-separated output file with the following columns:

Column | Example | Description
-------|---------|------------
FILE | Ecoli.fna | The filename this hit came from
SEQUENCE | contig000324 | The sequence in the filename
START | 23423 | Start coordinate in the sequence
END | 24117 | End coordinate
GENE | tet(M) | AMR gene name
COVERAGE | 1-1920/1920 | What proportion of the gene is in our sequence
COVERAGE_MAP | =============== | A visual represenation
GAPS | 1/4 | Openings / gaps in subject and query - possible psuedogene?
%COVERAGE | 100.00% | Proportion of gene covered 
%IDENTITY | 99.95% | Proportion of exact nucleotide matches
DATABASE | card | The database this sequence comes from
ACCESSION | NC_009632:49744-50476 | The genomic source of the sequence

## Caveats

* Does not find mutational resistance, only acquired genes.
* Gap reporting incomplete
* Sometimes two heavily overlapping genes will be reported for the same locus
* Possible coverage calculation issues

## Databases

ABRicate comes with some pre-downloaded databases:

* [Resfinder](https://cge.cbs.dtu.dk/services/ResFinder/)
* [ARG-ANNOT](http://en.mediterranee-infection.com/article.php?laref=283%26titre=arg-annot)
* [CARD](https://card.mcmaster.ca/)
* [NCBI Betalactamase Database](https://www.ncbi.nlm.nih.gov/pathogens/beta-lactamase-data-resources/)
* [PlasmidFinder](https://cge.cbs.dtu.dk/services/PlasmidFinder/)
* [VFDB](http://www.mgc.ac.cn/VFs/)

You can check what you have installed with the `--list` command:
```
% abricate --list

argannot:  1749 sequences -  Mar 17, 2017
card:  2117 sequences -  Mar 18, 2017
ncbibetalactamase:  1557 sequences -  Mar 17, 2017
resfinder:  2130 sequences -  Mar 17, 2017
vfdb:  2597 sequences -  Mar 17, 2017
```
The default database is currently `resfinder`.
You can choose a different database using the `--db` option:
```
% abricate --db vfdb --quiet 6159.fa

6159.fna  NC_017338.1  2724620  2726149  aur      1-1530/1530     ===============  0/0    100.00     99.346     vfdb      NP_647375
6159.fna  NC_017338.1  2766595  2767155  icaR     1-561/561       ===============  0/0    100.00     98.930     vfdb      NP_647402
6159.fna  NC_017338.1  2767319  2768557  icaA     1-1239/1239     ===============  0/0    100.00     99.677     vfdb      NP_647403
6159.fna  NC_017338.1  2768521  2768826  icaD     1-306/306       ===============  0/0    100.00     99.020     vfdb      NP_647404
6159.fna  NC_017338.1  2768823  2769695  icaB     1-873/873       ===============  0/0    100.00     99.542     vfdb      NP_647405
6159.fna  NC_017338.1  2769682  2770734  icaC     1-1053/1053     ===============  0/0    100.00     98.955     vfdb      NP_647406
6159.fna  NC_017338.1  2771040  2773085  lip      1-2046/2046     ===============  0/0    100.00     98.778     vfdb      NP_647407
```

## Combining reports across samples

ABRicate can combine results into a simple matrix of gene presence/absence.

```
# Run abricate on each .fa file
% abricate 1.fna > 1.tab
% abricate 2.fna > 2.tab

# Combine
% abricate --summary 1.tab 2.tab

#FILE     NUM_FOUND  aac(6')-aph(2'')_1  aadD_1  blaZ_32  blaZ_36  erm(A)_1       mecA_15  norA_1  spc_1          tet(M)_7
1.fna     8          100.00              100.00  .        100.00   100.00;100.00  100.00   99.91   100.00;100.00  100.00
2.fna     3          .                   .       100.00   .        .              100.00   99.91   .              .
```

## Updating the databases

```
# force download of latest version
% abricate-get_db --db resfinder --force

# re-use existing download and just regenerate the database
% abricate-get_db --db resfinder
```

## Making your own database

Let's say you want to make your own database called `tinyamr`. 
All you need is a FASTA file of nucleotide sequences, say `tinyamr.fa`.
Idealy the sequence IDs would have the format `>DB~~~ID~~~ACC DESC`
where `DB` is `tinyamr`, `ID` is the gene name, and `ACC` is an accession
number of the sequence source. The `DESC` can be any textual description.

```
% cd /path/to/abricate/db     # this is the --datadir default option
% mkdir tinyamr
% cp /path/to/tinyamr.fa sequences
% makeblastdb -in sequences -title tinyamr -dbtype nucl -parse_seqids -hash_index

% abricate --list
tinyamr:  173 sequences -  Mar 18, 2017

% abricate --db tinyamr screen_this.fasta
```

## Etymology

The name "ABRicate" was chosen as the first 3 letters are a common acronym
for "Anti-Biotic Resistance". It laso has the form of an English _verb_, 
which suggests the tool actual taking "action" against the problem of antibiotic resistance.
It is also relatively unique in [Google](https://www.google.com.au/search?q=abricate),
and is unlikely to receive an infamous [JABBA Award](http://www.acgt.me/blog/2014/12/1/time-for-a-new-jabba-award-for-just-another-bogus-bioinformatics-acronym).


## Issues

Please report problems here: https://github.com/tseemann/abricate/issues

## License

GPL Version 2: https://raw.githubusercontent.com/tseemann/abricate/master/LICENSE

## Author

Torsten Seemann | [@torstenseemann](https://twitter.com/torstenseemann) | [blog](http://thegenomefactory.blogspot.com/)
