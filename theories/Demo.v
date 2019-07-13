From CW Require Import Loader.

Axiom my_ax : True = False.

Lemma lemma1 : True = False.
Proof.
exact my_ax.
Qed.

Lemma lemma2 : True = False.
Admitted.

From Coq Require Classical.

Module Test.

Import Classical.

Lemma lemma3 : (2 = 3) \/ ~(2 = 3).
Proof.
apply classic.
Qed.

End Test.

CWGroup "Assumption Tests".

Fail CWTest lemma1 Assumes.
CWTest lemma1 Assumes my_ax.
Fail CWTest lemma1 Assumes Classical_Prop.classic.
Fail CWTest "lemma1" lemma1 Assumes lemma2.
CWTest lemma1 Assumes Classical_Prop.classic my_ax.
Fail CWTest "lemma2" lemma2 Assumes my_ax.

CWTest Test.lemma3 Assumes Classical_Prop.classic my_ax.
Fail CWTest Test.lemma3 Assumes my_ax.

CWEndGroup.

CWFile "theories/Demo.v" Size < 1000.
Fail CWFile "theories/Demo.v" Size < 200.

CWFile "theories/Demo.v" Matches "Axiom".
Fail CWFile "theories/Demo.v" Matches "$Theorem".

Fail CWFile "theories/Demo.v" Does Not Match "Axiom".
CWFile "theories/Demo.v" Does Not Match "$Theorem".
