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

Fail CWAssert lemma1 Assumes.
CWAssert lemma1 Assumes my_ax.
Fail CWAssert lemma1 Assumes Classical_Prop.classic.
Fail CWAssert "lemma1" lemma1 Assumes lemma2.
CWAssert lemma1 Assumes Classical_Prop.classic my_ax.
Fail CWAssert "lemma2" lemma2 Assumes my_ax.

CWAssert Test.lemma3 Assumes Classical_Prop.classic my_ax.
Fail CWAssert Test.lemma3 Assumes my_ax.

CWEndGroup.

CWGroup "File Tests".

CWFile "theories/Demo.v" Size < 1100.
Fail CWFile "theories/Demo.v" Size < 200.

CWFile "theories/Demo.v" Matches "Axiom".
Fail CWFile "theories/Demo.v" Matches "$Theorem".

Fail CWFile "theories/Demo.v" Does Not Match "Axiom".
CWFile "theories/Demo.v" Does Not Match "$Theorem".

CWEndGroup.