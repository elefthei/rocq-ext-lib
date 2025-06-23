From Stdlib Require Import Bool.
From Stdlib Require Import PeanoNat.
From ExtLib Require Import Tactics.Consider.
From ExtLib Require Import Data.Nat.

From Stdlib Require Import ZArith.
From Stdlib Require Import Lia.

Set Implicit Arguments.
Set Strict Implicit.

(**  Some tests *)
Section test.
  Goal forall x y z,  (Nat.ltb x y && Nat.ltb y z) = true ->
                 Nat.ltb x z = true.
  intros x y z.
  consider (Nat.ltb x y && Nat.ltb y z).
  consider (Nat.ltb x z); auto. intros. exfalso. lia.
  Qed.

  Goal forall x y z,
    Nat.ltb x y = true ->
    Nat.ltb y z = true ->
    Nat.ltb x z = true.
  Proof.
    intros. consider (Nat.ltb x y); consider (Nat.ltb y z); consider (Nat.ltb x z); intros; auto.
    exfalso; lia.
  Qed.

End test.
