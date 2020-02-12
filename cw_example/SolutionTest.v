Require Solution.
Require Import Preloaded.
From CW Require Import Loader.

CWStopOnFailure 0.

CWGroup "Tests for Solution.solution".
  CWTest "Type test".
    (* The expected type should be in parentheses *)
    CWAssert "Should fail" Solution.solution : (1 + 1 = 2).
    CWAssert Solution.solution : (1 + 1 = 3).
  (* CWEndTest is optional before CWTest or CWEndGroup *)
  CWEndTest.
  CWTest "Assumptions test".
    CWAssert "Testing solution" Solution.solution Assumes test_axiom.
    CWAssert "Testing solution (failure)" Solution.solution Assumes. (*test_axiom.*)
    CWAssert "Testing solution2" Solution.solution2 Assumes test_axiom another_axiom.
    CWAssert "Testing solution2 (failure 1)" Solution.solution2 Assumes test_axiom.
    CWAssert "Testing solution2 (failure 2)" Solution.solution2 Assumes.
  CWTest "Type test 2".
    Definition expected := 1 + 1 = 3.
    CWAssert Solution.solution : expected.
CWEndGroup.

Definition solution_test := Solution.solution.

CWGroup "Another test
with line breaks".
  CWAssert "Testing solution_test
(line break)" solution_test Assumes test_axiom.
CWEndGroup.

CWTest "Without group".
  CWAssert solution_test Assumes test_axiom.
CWEndTest.

CWGroup "Nested groups".
  CWGroup "Level 2".
    CWTest "Test 1".
      CWAssert solution_test Assumes test_axiom.
  CWEndGroup.
  CWTest "Test 2".
    CWAssert solution_test Assumes test_axiom.
    CWAssert solution_test Assumes test_axiom.
  CWEndTest.
CWEndGroup.
