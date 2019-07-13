# A Coq plugin for Codewars

## Installation

Create a make file:
```
coq_makefile -f _CoqProject -o Makefile
```

Now run `make`.

## Extra

Run `make .merlin` to create the `.merlin` file.

## New Vernacular Commands

- `CWTest string? qualid Assumes qualid*`

   This command fails if the tested `qualid` depends on an axiom which is not listed after `Assumes`:

   ```coq
   CWTest "Testing lemma" lemma Assumes proof_irrelevance functional_extensionality.
   ```
   The string argument after `CWTest` is an optional message.

- `CWGroup string`
   
   Begins a group of tests.

- `CWEndGroup`

   Ends a group of tests.

- `CWFile string? Size < int`

   Tests if the size of a file (the first string argument) is less than the second argument.

   The file name is optional. The default file is the solution file.

- `CWFile string? Matches string`

   Tests if the content of a file matches a regular expression (the second argument). The regular expression syntax is [OCaml Str](https://caml.inria.fr/pub/docs/manual-ocaml/libref/Str.html) (`\` should not be escaped).

- `CWFile string? Does Not Match string`

   Tests if the content of a file does not match a regular expression (the second argument).

## Examples

See [theories/Demo.v](theories/Demo.v) and [theories/Demo2.v](theories/Demo2.v)
for more examples.

Compiling demo files:
```
coqc -I src -R theories/ CW theories/Demo.v
coqc -I src -R theories/ CW theories/Demo2.v
```