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

A new vernacular command `CWTest msg? qualid Assumes qualid*` is defined.
This command fails if the tested `qualid` depends on an axiom which is not listed
after `Assumes`:

```coq
CWTest "Testing lemma" lemma Assumes proof_irrelevance functional_extensionality.
```

The string argument after `CWTest` (`msg`) is optional.

Two other commands are `CWGroup msg` and `CWEndGroup`.

## Examples

See [theories/Demo.v](theories/Demo.v) and [theories/Demo2.v](theories/Demo2.v)
for more examples.