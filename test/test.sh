#!/usr/bin/env bats

setup () {
  name="abricate"
  bats_require_minimum_version 1.5.0
  dir=$(dirname "$BATS_TEST_FILENAME")
  cd "$dir"
  exe="$dir/../bin/$name"
  cpus=$(nproc)
  issue229_fixture="$dir/fixtures/issue229"
  issue229_scratch=$(mktemp -d)
  mkdir -p "$issue229_scratch/databases/tinyprot"
  cp "$issue229_fixture/synthetic_protein.fa" "$issue229_scratch/databases/tinyprot/sequences"
  makeblastdb -in "$issue229_scratch/databases/tinyprot/sequences" -title tinyprot -dbtype prot -out "$issue229_scratch/databases/tinyprot/sequences" >/dev/null
}

teardown () {
  [[ -n "$issue229_scratch" && -d "$issue229_scratch" ]] && rm -rf "$issue229_scratch"
}

@test "Script syntax check" {
  run -0 perl -c "$exe"
}
@test "Version" {
  run -0 $exe --version
  [[ "$output" =~ "$name " ]]
}
@test "Help" {
  run -0 $exe --help
  [[ "$output" =~ "identity" ]]
}
@test "Check deps" {
  run -0 $exe --check
  [[ "$output" =~ "OK." ]]
}
@test "No parameters" {
  run ! $exe
}
@test "Bad option" {
  run ! $exe --semmelweiss
  [[ "$output" =~ "Unknown" ]]
}
@test "Set up  databases" {
  run $exe --setupdb
}
@test "List databases" {
  run -0 $exe --list
  [[ "$output" =~ "ncbi" ]]
  [[ "$output" =~ "card" ]]
}

@test "FASTA input" {
  run -0 $exe -q assembly.fa
  [[ "${lines[0]}" =~ "SEQUENCE" ]]
  [[ "$output" =~ "blaZ" ]]
  [[ "$output" =~ "FOSFOMYCIN" ]]
}
@test "GENBANK input" {
  run -0 $exe -q assembly.gbk
  [[ "${lines[0]}" =~ "SEQUENCE" ]]
  [[ "$output" =~ "blaZ" ]]
  [[ "$output" =~ "FOSFOMYCIN" ]]
}
@test "GZIP compressed" {
  run -0 $exe -q assembly.fa.gz
  [[ "${lines[0]}" =~ "SEQUENCE" ]]
  [[ "$output" =~ "blaZ" ]]
  [[ "$output" =~ "FOSFOMYCIN" ]]
}
@test "BZIP2 compressed" {
  run -0 $exe -q assembly.fa.gz
  [[ "${lines[0]}" =~ "SEQUENCE" ]]
  [[ "$output" =~ "blaZ" ]]
  [[ "$output" =~ "FOSFOMYCIN" ]]
}
@test "Option --quiet" {
  run -0 $exe --quiet assembly.fa
  [[ ! "$output" =~ "Processing:" ]]
}
@test "Option --csv" {
  run -0 $exe -q --csv assembly.fa
  [[ "${lines[0]}" =~ "SEQUENCE,START,END" ]]
}
@test "Option --identity" {
  run -0 $exe -q --identity assembly.fa
  [[ "${lines[0]}" =~ "%IDENTITY" ]]
}
@test "Option --noheader" {
  run -0 $exe -q --noheader assembly.fa
  [[ ! "${lines[0]}" =~ "SEQUENCE" ]]
}
@test "Option --threads" {
  run -0 $exe -q --threads $cpus assembly.gbk.gz
  [[ "$output" =~ "START" ]]
}

@test "Bad --minid" {
  run ! $exe --minid BADNUMBER assembly.fa
}
@test "Bad --mincov" {
  run ! $exe --mincov BADNUMBER assembly.fa
}
@test "Bad --threads" {
  run ! $exe --threads -666 assembly.fa
}

@test "Protein --minid 80 filters below-threshold BLASTX hits" {
  run -0 "$exe" --quiet --datadir "$issue229_scratch/databases" --db tinyprot --minid 80 --mincov 0 "$issue229_fixture/low_identity_dna.fa"
  ! printf '%s\n' "$output" | awk -F '\t' 'NR>1 && NF>=11 && ($11+0)<80 {found=1} END {exit !found}'
}

@test "Protein --minid 80 retains above-threshold BLASTX hits" {
  run -0 "$exe" --quiet --datadir "$issue229_scratch/databases" --db tinyprot --minid 80 --mincov 0 "$issue229_fixture/high_identity_dna.fa"
  printf '%s\n' "$output" | awk -F '\t' 'NR>1 && NF>=11 && ($11+0)>=80 {found=1} END {exit !found}'
}

@test "Protein alternate cutoff filters the 92 percent hit" {
  run -0 "$exe" --quiet --datadir "$issue229_scratch/databases" --db tinyprot --minid 95 --mincov 0 "$issue229_fixture/high_identity_dna.fa"
  ! printf '%s\n' "$output" | awk -F '\t' 'NR>1 && NF>=11 {found=1} END {exit !found}'
}

@test "Protein identity at the reported threshold is retained" {
  run -0 "$exe" --quiet --datadir "$issue229_scratch/databases" --db tinyprot --minid 92.05 --mincov 0 "$issue229_fixture/high_identity_dna.fa"
  printf '%s\n' "$output" | awk -F '\t' 'NR>1 && NF>=11 && ($11+0)>=92.05 {found=1} END {exit !found}'
}

@test "Nucleotide mode still enforces --minid through BLASTN" {
  mkdir -p "$issue229_scratch/databases/tinynucl"
  cp "$issue229_fixture/high_identity_dna.fa" "$issue229_scratch/databases/tinynucl/sequences"
  makeblastdb -in "$issue229_scratch/databases/tinynucl/sequences" -title tinynucl -dbtype nucl -out "$issue229_scratch/databases/tinynucl/sequences" >/dev/null
  run -0 "$exe" --quiet --datadir "$issue229_scratch/databases" --db tinynucl --minid 100 --mincov 0 "$issue229_fixture/high_identity_dna.fa"
  printf '%s\n' "$output" | awk -F '\t' 'NR>1 && NF>=11 && ($11+0)>=100 {found=1} END {exit !found}'
}
