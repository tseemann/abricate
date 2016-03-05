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

The current database is built from [ResFinder](http://cge.cbs.dtu.dk/services/ResFinder/).

```
% abricate --list
aminoglycoside  164
beta-lactamase  1310
colistin        1
fosfomycin      21
fusidicacid     3
macrolide       136
nitroimidazole  14
oxazolidinone   3
phenicol        36
quinolone       103
rifampicin      9
sulphonamide    50
tetracycline    113
trimethoprim    53
vancomycin      124
TOTAL   2140
```

The raw ResFinder database is processed using the `scripts/abricate-fix_resfinder_fasta` tool which:
* removes redundant sequences
* re-orients backward sequences
* removes sequences with non-DNA bases 
* removes partial coding sequences
This could have unexpected consequences on your results and needs to be investigated 
further with the curators of ResFinder.

##Updating the database

If you don't want to wait for a new release of Abricate you can updated the `db` folder manually.

```
# Download and create a new db.XXXXXX folder
cd /path/to/abricate/scripts
./abricate-update_db

# Check it all looks ok
ls -l db.XXXXXX

# Replace the old db folder
mv ../db ../db.old
mv db.XXXXXX ../db

# See if it worked
abricate --list
```

##Adding your own sequences

There is nothing particularly special about ABRicate - it's just a glorified BLASTN tool.
If you want to add in your own sequences, just add them to the BLASTN database `db/resfinder`.
The sequence ID that is reported is the FASTA ID, 
but stripped to the right after the first underscore '_'.

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


