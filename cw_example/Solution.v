Require Import Preloaded.

Lemma solution : 1 + 1 = 3.
Proof. firstorder using test_axiom. Qed.

Lemma solution2 : 1 + 1 = 3 /\ 2 + 2 = 4.
Proof. split; [firstorder using test_axiom | firstorder using another_axiom]. Qed.