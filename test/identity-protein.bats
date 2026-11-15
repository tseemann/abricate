#!/usr/bin/env bats
# Proposed regression for issue #229. Requires BATS, BLAST+, any2fasta, and ABRicate Perl deps.
# Run from repository root: bats test/identity-protein.bats

setup() {
  bats_require_minimum_version 1.5.0
  repo_root="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"
  exe="$repo_root/bin/abricate"
  fixture="$repo_root/test/fixtures/issue229"
  scratch="$(mktemp -d)"
  mkdir -p "$scratch/databases/tinyprot"
  cp "$fixture/synthetic_protein.fa" "$scratch/databases/tinyprot/sequences"
  makeblastdb -in "$scratch/databases/tinyprot/sequences" -title tinyprot -dbtype prot -out "$scratch/databases/tinyprot/sequences" >/dev/null || return 1
}

teardown() {
  [[ -n "$scratch" && -d "$scratch" ]] && rm -rf "$scratch"
}

@test "protein BLASTx hits honour --minid 80" {
  run -0 "$exe" --quiet --datadir "$scratch/databases" --db tinyprot --minid 80 --mincov 0 "$fixture/low_identity_dna.fa"
  # In production output, column 11 is %IDENTITY. Do not permit below-threshold hits.
  if printf '%s\n' "$output" | awk -F '\t' 'NR>1 && NF>=11 && ($11+0)<80 {bad=1} END {exit !bad}'; then
    echo "below-threshold protein hit escaped --minid 80: $output" >&2
    return 1
  fi
}

@test "high-identity translated nucleotide hit remains reportable" {
  run -0 "$exe" --quiet --datadir "$scratch/databases" --db tinyprot --minid 80 --mincov 0 "$fixture/high_identity_dna.fa"
  printf '%s\n' "$output" | awk -F '\t' 'NR>1 && NF>=11 && ($11+0)>=80 {found=1} END {exit !found}'
}
