From CW Require Import Loader.

Axiom my_ax : True = False.

Lemma lemma1 : True = False.
Proof.
exact my_ax.
Qed.

Lemma lemma2 : True = False.
Admitted.

From Coq Require Import Classical.

Lemma lemma3 : (2 = 3) \/ ~(2 = 3).
Proof.
apply classic.
Qed.
  
Fail CWTest lemma1 Assumes.
CWTest lemma1 Assumes my_ax.
Fail CWTest lemma1 Assumes classic.
CWTest lemma1 Assumes lemma2.
CWTest lemma1 Assumes classic my_ax.
CWTest lemma2 Assumes my_ax.

CWTest lemma3 Assumes classic my_ax.
Fail CWTest lemma3 Assumes my_ax.