#!/usr/bin/env -S sh -c 'f=$(mktemp); tail +2 $0 > $f; lean --run $f'

def eval (line : String) : Except String Int := do
  let mut stack := []

  for token in line.split Char.isWhitespace do
    if token.isEmpty then
      continue

    if let some x := token.toInt? then
      stack := x :: stack
      continue

    let op <- match token.toString with
      | "+" => pure (· + ·)
      | "-" => pure (· - ·)
      | "*" => pure (· * ·)
      | "/" => pure (· / ·)
      | _ => throw "Invalid Token"

    match stack with
    | b :: a :: rest => stack := op a b :: rest
    | _ => throw "Too Few Arguments"

  match stack with
  | [x] => pure x
  | _ => throw "Invalid Input"

def main : IO Unit := do
  let stdin <- IO.getStdin
  repeat
    match eval (<- stdin.getLine) with
    | .ok x => IO.println x
    | .error e => IO.println e
