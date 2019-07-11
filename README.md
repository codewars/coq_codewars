# A Coq plugin for Codewars

## Installation

Create a make file:
```
coq_makefile -f _CoqProject -o Makefile
```

Now run `make`.

## Extra

Run `make .merlin` to create the `.merlin` file.

## Examples

A new vernacular command `CWTest qualid Assumes qualid*` is defined.
This command fails if the tested `qualid` depends on an axiom which is not listed
after `Assumes`:

```coq
CWTest lemma Assumes proof_irrelevance functional_extensionality.
```

See [theories/Demo.v](theories/Demo.v) and [theories/Demo.v2](theories/Demo.v2)
for more examples.