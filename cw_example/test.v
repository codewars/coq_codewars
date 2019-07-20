Require solution.
Require Import preloaded.
From CW Require Import Loader.

CWGroup "Tests for solution.solution".
  CWTestCase "Type test".
    Example solution_test : 1 + 1 = 3.
    Proof. exact solution.solution. Qed.
  CWTestCase "Assumptions test".
    CWAssert "Testing solution" solution.solution Assumes test_axiom.
CWEndGroup.

CWGroup "Another test
with line breaks".
  CWAssert "Testing solution_test
(line break)" solution_test Assumes test_axiom.
CWEndGroup.

CWTestCase "Without group".
  CWAssert solution_test Assumes test_axiom.
CWEnd.

CWGroup "Nested groups".
  CWGroup "Level 2".
    CWTestCase "Test 1".
      CWAssert solution_test Assumes test_axiom.
  CWEndGroup.
  CWTestCase "Test 2".
    CWAssert solution_test Assumes test_axiom.
    CWAssert solution_test Assumes test_axiom.
  CWEnd.
CWEndGroup.
