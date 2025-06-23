From Stdlib Require Import Bool.Bool.
From ExtLib Require Import Structures.Sets.
From ExtLib Require Import Structures.Reducible.
From ExtLib Require Import Structures.Functor.

Set Implicit Arguments.
Set Strict Implicit.

(** Program with respect to the set interface **)
Section with_set.
  Variable V : Type.
  Context {set : Type}.
  Context {Set_set : DSet set V}.

  Definition contains_both (v1 v2 : V) (s : set) : bool :=
    contains v1 s && contains v2 s.

  (** Iteration requires foldability **)
  Context {Foldable_set : Foldable set V}.

  Definition toList (s : set) : list V :=
    fold (@cons _) nil s.

End with_set.

(** Instantiate the set **)
From ExtLib Require Import Data.Set.ListSet.

Eval compute in contains_both 0 1 empty.

Eval compute in toList (add true (add true empty)).

Eval compute in fmap negb (add true empty).