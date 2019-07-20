Require solution.
Require Import preloaded.
From CW Require Import Loader.

CWGroup "Tests for solution.solution".
  CWTestCase "Type test".
    Fail CWAssert "Should fail" solution.solution : (1 + 1 = 2).
    CWAssert solution.solution : (1 + 1 = 3).
  CWTestCase "Assumptions test".
    CWAssert "Testing solution" solution.solution Assumes test_axiom.
CWEndGroup.

Definition solution_test := solution.solution.

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
