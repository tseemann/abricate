#!/usr/bin/env bats

setup () {
  name="abricate"
  bats_require_minimum_version 1.5.0
  dir=$(dirname "$BATS_TEST_FILENAME")
  cd "$dir"
  exe="$dir/../bin/$name"
  cpus=$(nproc)
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
