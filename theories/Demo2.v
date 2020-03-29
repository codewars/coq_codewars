Require Import Arith Lia Program.

Program Fixpoint fib_prog (n : nat) {wf lt n} : nat :=
  match n with 0 => 0 | 1 => 1 | S (S n) => fib_prog (S n) + fib_prog n end.

Theorem fib0 : fib_prog 0 = 0.
Proof. auto. Qed.

Theorem fib1 : fib_prog 1 = 1.
Proof. auto. Qed.

Theorem fibSS : forall n, fib_prog (S (S n)) = fib_prog (S n) + fib_prog n.
Proof. intros. unfold fib_prog at 1. rewrite fix_sub_eq.
  - fold fib_prog. simpl. auto.
  - intros. destruct x as [ | [ | ]]; auto. Qed.

From CW Require Import Loader.

CWGroup "Program tests".

CWAssert fib0 Assumes.
CWAssert fib1 Assumes.
Fail CWAssert fibSS Assumes.

CWAssert fibSS Assumes proof_irrelevance.
Fail CWAssert fibSS Assumes functional_extensionality_dep.

CWEndGroup.

From Equations Require Import Equations.

Equations fibE (n : nat) : nat by wf n lt :=
fibE 0 := 0;
fibE 1 := 1;
fibE (S (S n)) := fibE (S n) + fibE n.
Check fibE_equation_3.

Print Assumptions fibE_equation_3.

CWGroup "Equations tests".

Fail CWAssert fibE_equation_3 Assumes.
Fail CWAssert fibE_equation_3 Assumes proof_irrelevance.
CWAssert fibE_equation_3 Assumes functional_extensionality_dep.

CWEndGroup.

From Coq Require Import Reals.

Print Assumptions sqrt_pos.

CWGroup "Real numbers".

Fail CWAssert sqrt_pos Assumes.
CWAssert "Real Number Axioms (Dedekind)" sqrt_pos Assumes
  ClassicalDedekindReals.sig_not_dec
  ClassicalDedekindReals.sig_forall_dec
  functional_extensionality_dep.

(* CWAssert "Real Number Axioms" sqrt_pos Assumes
  R R0 R1 Rplus Rmult Ropp Rinv Rlt up
  Rplus_comm Rplus_assoc Rplus_opp_r Rplus_0_l
  Rmult_comm Rmult_assoc Rinv_l Rmult_1_l R1_neq_R0
  Rmult_plus_distr_l total_order_T
  Rlt_asym Rlt_trans Rplus_lt_compat_l Rmult_lt_compat_l
  archimed completeness.   *)

CWEndGroup.