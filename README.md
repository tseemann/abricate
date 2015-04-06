#ABRicate

Mass screening of contigs for antiobiotic resistance genes.

By Torsten Seemann | [@torstenseemann](https://twitter.com/torstenseemann) | [blog](http://thegenomefactory.blogspot.com/)

##Quick Start

```
% abricate 6008.fasta
#FILE	SEQUENCE	START	END	GENE	COVERAGE	COVERAGE_MAP	GAPS	%COVERAGE	%IDENTITY
Processing: 6008.fna
Found 12 ABR genes in 6008.fna
Klebsiella.fna	NC_021232.1	872545	872964	fosA	1-420/420	===============	0	100.00	100.00
Klebsiella.fna	NC_021232.1	1381252	1382427	oqxA	1-1176/1176	===============	0	100.00	99.32
Klebsiella.fna  NC_021232.1 2584899	2585759	blaSHV1	1-861/861	===============	0	100.00	99.88
```

##Installation

###Brew
If you are using the [OSX Brew](http://brew.sh/) or [LinuxBrew](http://brew.sh/linuxbrew/) packaging system:

    brew tap homebrew/science
    brew tap tseemann/homebrew-bioinformatics-linux
    brew install abricate

###Source
If you don't use Brew, you will also need to make sure you have BLAST+ installed for ```blastn```.
    
    git clone https://github.com/tseemann/abricate.git
    ./abricate/bin/abricate --help

##Input

Abricate takes FASTA contig files. It can take multiple fasta files at once!

    % abricate ref.fa strains*.fasta /ncbi/Ecoli/*.fna

It does not accept raw FASTQ reads; please see [SRTS2](https://github.com/katholt/srst2) for that.

##Output

Abricate produces a tap-separated output file with the following columns:

Column | Example | Description
-------|---------|------------
FILE | Ecoli.fna | The filename this hit came from
SEQUENCE | contig000324 | The sequence in the filename
START | 23423 | Start coordinate in the sequence
END | 24117 | End coordinate
GENE | tet(M) | ABR gene
COVERAGE | 1-1920/1920 | What proportion of the gene is in our sequence
COVERAGE_MAP | =============== | A visual represenation
GAPS | 0 | Was there any gaps in the alignment - possible pseudogene?
%COVERAGE | 100.00% | Proportion of gene covered 
%IDENTITY | 99.95% | Proportion of exact nucleotide matches

##Caveats

* Whole codon gaps (3 bp) are still listed as frame-shifts
* Gap reporting incomplete
* Possible coverage calculation issues

##Database

The current database is built on [ResFinder](http://cge.cbs.dtu.dk/services/ResFinder/).
It contains 2203 genes across 13 drug classes:

```
% abricate --list
aminoglycoside	166
beta-lactamase	1328
fosfomycin	21
fusidicacid	4
macrolide	140
nitroimidazole	14
phenicol	35
quinolone	114
rifampicin	12
sulphonamide	56
tetracycline	118
trimethoprim	59
vancomycin	136
TOTAL	2203
```

I curated it by removing redundant sequences, re-orienting backward sequences, and removing
sequences with non-DNA bases and partial coding sequences.

There is a newer 2.1 version which I it does not seem to be downloadable yet.

##Issues

Please report problems here: https://github.com/tseemann/abricate/issues

##License

GPL Version 2: https://raw.githubusercontent.com/tseemann/abricate/master/LICENSE

##Etymology

The name "ABRicate" was chosen as the first 3 letters are a common acronym
for "Anti-Biotic Resistance". It laso has the form of an English _verb_, 
which suggests the tool actual taking "action" against the problem of antibiotic resistance.
It is also relatively unique in [Google](https://www.google.com.au/search?q=abricate),
and is unlikely to receive an infamous [JABBA Award](http://www.acgt.me/blog/2014/12/1/time-for-a-new-jabba-award-for-just-another-bogus-bioinformatics-acronym).


