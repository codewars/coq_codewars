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

- `CWAssert string? qualid Assumes qualid*`

   This command fails if the tested `qualid` depends on an axiom which is not listed after `Assumes`:

   ```coq
   CWAssert "Testing lemma" lemma Assumes proof_irrelevance functional_extensionality.
   ```
   The string argument after `CWAssert` is an optional message.

- `CWAssert string? qualid : term`

   Checks if the type of `qualid` is convertible to the type given by `term`.

   ```coq
   CWAssert "Testing type" lemma : (forall x, x > 0).
   ```
   The string argument after `CWAssert` is an optional message.

   Note that the `term` should be in parentheses.

- `CWGroup string`
   
   Begins a group of tests (outputs `<DESCRIBE::>`).

   Groups can be nested. But all tests should be performed after `CWTest` in nested groups.

- `CWEndGroup`

   Ends a group of tests.

- `CWTest string`

   Begins a test case (outputs `<IT::>`).

   Test cases cannot be nested.

- `CWEndTest`.

   Ends a test case. This command is optional before `CWTest` and `CWEndGroup`.

- `CWFile string? Size < int`

   Tests if the size of a file (the first string argument) is less than the second argument.

   The file name is optional. The default file is the solution file.

- `CWFile string? Matches string`

   Tests if the content of a file matches a regular expression (the second argument). The regular expression syntax is [OCaml Str](https://caml.inria.fr/pub/docs/manual-ocaml/libref/Str.html) (`\` should not be escaped).

- `CWFile string? Does Not Match string`

   Tests if the content of a file does not match a regular expression (the second argument).

## Examples

See [cw_example/SolutionTest.v](cw_example/SolutionTest.v).

More examples are in [theories/Demo.v](theories/Demo.v) and [theories/Demo2.v](theories/Demo2.v).

Compiling demo files:
```
coqc -I src -R theories/ CW theories/Demo.v
coqc -I src -R theories/ CW theories/Demo2.v
```