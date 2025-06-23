From Stdlib Require Import Strings.String.
From ExtLib Require Import Structures.MonadWriter.
From ExtLib Require Import Data.PPair.
From ExtLib Require Import Data.Monads.WriterMonad.
From ExtLib Require Import Data.Monads.IdentityMonad.
From ExtLib Require Import Programming.Show.

Definition PrinterMonad : Type -> Type :=
  writerT (@show_mon _ ShowScheme_string_compose) ident.

Definition print {T : Type} {ST : Show T} (val : T) : PrinterMonad unit :=
  @MonadWriter.tell _ (@show_mon _ ShowScheme_string_compose) _ _
                    (@show _ ST val _ show_inj (@show_mon _ ShowScheme_string_compose)).

Definition printString (str : string) : PrinterMonad unit :=
  @MonadWriter.tell _ (@show_mon _ ShowScheme_string_compose) _ _
                    (@show_exact str _ show_inj (@show_mon _ ShowScheme_string_compose)).

Definition runPrinter {T : Type} (c : PrinterMonad T) : T * string :=
  let '(ppair val str) := unIdent (runWriterT c) in
  (val, str ""%string).


Eval compute in
    runPrinter (Monad.bind (print 1) (fun _ => print 2)).

Eval compute in
    runPrinter (Monad.bind (print "hello "%string) (fun _ => print 2)).
Eval compute in
    runPrinter (Monad.bind (printString "hello "%string) (fun _ => print 2)).