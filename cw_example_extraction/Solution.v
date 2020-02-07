Fixpoint factorial n :=
  match n with
  | O => 1
  | S n => S n * factorial n
  end.