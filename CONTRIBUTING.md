# Contributing to Abricate

Thank you for your interest in 
improving Abricate!  
Contributions from the
community help make this tool 
better for everyone.

Here are the simple guidelines 
for contributing to the project.

## Found a bug or have a feature request?

Please do not email me directly 
or submit code changes without
context.  Instead, please
[file an issue on the GitHub Issues page](https://github.com/tseemann/abricate/issues).

When reporting a bug, please include:
* The exact command you ran.
* The version of Abricate you are using (`abricate --version`).
* Any relevant error messages or unexpected output.

## Submitting a Pull Request (PR)

We welcome pull requests! 
To ensure your code changes 
are accepted smoothly, 
please make sure your PR 
follows these requirements:

1. **Write a test:** You must add a corresponding test case for your change in the BATS (Bash Automated Testing System) test suite located in `test/test.sh`.
2. **Include test data:** If your test relies on specific files (e.g., small FASTA or GenBank files), please add these sample files to the `test/` directory.
3. **Verify locally:** Run `bats test/test.sh` locally to ensure all existing and new tests pass successfully before submitting your PR.

Thank you for keeping the code 
robust and tested!

