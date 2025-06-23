From Stdlib Require Import Relations.
From ExtLib Require Import Data.Fun.
From ExtLib Require Import Structures.Functor.

Set Implicit Arguments.
Set Strict Implicit.
Set Universe Polymorphism.

Section laws.

  Class FunctorLaws {F} (Functor_F : Functor F) :=
  { fmap_id : forall {T} (x : F T), fmap id x = x
  ; fmap_compose : forall {T U V} (f : T -> U) (g : U -> V) (x : F T),
        fmap (compose g f) x = fmap g (fmap f x)
  }.
End laws.
