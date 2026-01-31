#!/usr/bin/env bats

setup () {
  name="abricate"
  bats_require_minimum_version 1.5.0
  dir=$(dirname "$BATS_TEST_FILENAME")
  cd "$dir"
  exe="$dir/../bin/$name"
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
  run $exe --list
  [[ "$output" =~ "ncbi" ]]
  [[ "$output" =~ "nucl" ]]
}
