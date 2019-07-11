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

CWTest fib0 Assumes.
CWTest fib1 Assumes.
Fail CWTest fibSS Assumes.

CWTest fibSS Assumes proof_irrelevance.
Fail CWTest fibSS Assumes functional_extensionality_dep.


From Equations Require Import Equations.

Equations fibE (n : nat) : nat by wf n lt :=
fibE 0 := 0;
fibE 1 := 1;
fibE (S (S n)) := fibE (S n) + fibE n.
Check fibE_equation_3.

Print Assumptions fibE_equation_3.

Fail CWTest fibE_equation_3 Assumes.
Fail CWTest fibE_equation_3 Assumes proof_irrelevance.
CWTest fibE_equation_3 Assumes functional_extensionality_dep.

From Coq Require Import Reals.

Print Assumptions sqrt_pos.

Fail CWTest sqrt_pos Assumes.
CWTest sqrt_pos Assumes R R1 R1_neq_R0 Rinv total_order_T
     completeness archimed Rplus_opp_r Rplus_lt_compat_l
     Rplus_comm Rplus_assoc Rplus_0_l Rplus Ropp
     Rmult_plus_distr_l Rmult_lt_compat_l Rmult_comm
     Rmult_assoc Rmult_1_l Rmult Rlt_trans Rlt_asym
     Rlt Rinv_l Rinv up.