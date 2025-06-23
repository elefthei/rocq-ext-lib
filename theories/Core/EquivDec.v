From Stdlib Require Import Classes.EquivDec.
From Stdlib Require Import Eqdep_dec.

Theorem EquivDec_refl_left {T : Type} {c : EqDec T (@eq T)} :
  forall (n : T), equiv_dec n n = left (refl_equal _).
Proof.
  intros. destruct (equiv_dec n n); try congruence.
  rewrite (Eqdep_dec.UIP_dec (A := T) (@equiv_dec _ _ _ c) e (refl_equal _)).
  reflexivity.
Qed.

Export EquivDec.
