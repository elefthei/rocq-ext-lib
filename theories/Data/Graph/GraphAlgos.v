Require Import Stdlib.Lists.List.
Require Import Stdlib.PArith.BinPos.
From ExtLib Require Import Structures.Monads.
From ExtLib Require Import Structures.Reducible.
From ExtLib Require Import Data.Graph.Graph.
From ExtLib Require Import Data.Monads.FuelMonad.
From ExtLib Require Import Data.Monads.IdentityMonad.
From ExtLib Require Import Data.List.
From ExtLib Require Import RelDec.


Set Implicit Arguments.
Set Strict Implicit.

Section GraphAlgos.
  Variable V : Type.
  Variable RelDec_V : RelDec (@eq V).
  Variable G : Type.

  Context {graph : Graph V G}.

  Section Traverse.
    Variable g : G.

    Fixpoint list_in_dec v (ls : list V) : bool :=
      match ls with
        | nil => false
        | l :: ls =>
          if eq_dec l v then true
          else list_in_dec v ls
      end.

    Section monadic.
      Variable m : Type -> Type.
      Context {Monad_m : Monad m} {MonadFix_m : MonadFix m}.

      Definition dfs' : V -> list V -> m (list V) :=
        mfix_multi (V :: list V :: nil) (list V) (fun rec from seen =>
          if list_in_dec from seen
          then ret (m:=m) seen
          else
            foldM (fun v acc =>
              if list_in_dec v acc
              then ret (m:=m) acc
              else rec v acc) (ret (m:=m) seen) (successors g from)).

    End monadic.

    Definition dfs (from : V) : list V :=
      let count := Npos (List.fold_left (fun acc _ => Pos.succ acc) (verticies g) 1%positive) in
      let res := runGFix (dfs' from nil) count in
      match res with
        | Diverge => (** This should never happen! **)
          verticies g
        | Term v => v
      end.

  End Traverse.
End GraphAlgos.