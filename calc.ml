#!/usr/bin/env ocaml

let parse = function
  | "+" -> Some (`Op ( + ))
  | "-" -> Some (`Op ( - ))
  | "*" -> Some (`Op ( * ))
  | "/" -> Some (`Op ( / ))
  | s -> s |> int_of_string_opt |> Option.map (fun n -> `Num n)

let eval item nums =
  let apply op = function
    | b :: a :: nums -> Ok (op a b :: nums)
    | _ -> Error "Too Few Arguments"
  in
  match parse item with
  | Some (`Op op) -> apply op nums
  | Some (`Num n) -> Ok (n :: nums)
  | None -> Error "Invalid Token"

let eval nums item = Result.bind nums (eval item)

let run line =
  match line |> String.split_on_char ' ' |> List.fold_left eval (Ok []) with
  | Ok [ x ] -> Int.to_string x
  | Error e -> e
  | _ -> "Invalid Input"

let read () =
  match read_line () with
  | s -> Some (String.trim s)
  | exception Sys.Break -> None

let () =
  Sys.catch_break true;
  Seq.of_dispenser read |> Seq.map run |> Seq.iter print_endline
