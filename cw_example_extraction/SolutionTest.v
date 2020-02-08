Require Solution.
Require Import Preloaded.
Require Coq.extraction.Extraction.
From CW Require Import Loader.

Extract Inductive nat => "int"
  ["0" "(fun x -> x + 1)"]
  "(fun zero succ n -> if n = 0 then zero () else succ (n - 1))".

Extract Constant plus => "( + )".
Extract Constant mult => "( * )".

CWTest "Successful Extraction Test".

Extraction "factorial.ml" Solution.factorial.

CWCompileAndRun "factorial.mli" "factorial.ml" Options "-verbose" Driver "
open Factorial
let () = 
  assert (factorial 3 = 6);
  assert (factorial 0 = 1);
  assert (factorial 5 = 120)
".

CWTest "Extraction Test With Errors".

Extract Constant mult => "*".

Extraction "factorial.ml" Solution.factorial.

CWCompileAndRun "factorial.mli" "factorial.ml" Options "-verbose" Driver "
open Factorial
let () = 
  assert (factorial 3 = 6);
  assert (factorial 0 = 1);
  assert (factorial 5 = 120)
".

CWEndTest.

