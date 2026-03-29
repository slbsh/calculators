#!/usr/bin/env ocaml

let op = function
	| "+" -> Some ( + )
	| "-" -> Some ( - )
	| "*" -> Some ( * )
	| "/" -> Some ( / )
	| _ -> None

let eval line =
	let step tok st =
		match op tok with
		| Some f -> (
			match st with
			| a :: b :: st' -> Ok (f b a :: st')
			| _ -> Error "Too Few Arguments")
		| None ->
			Option.(
				tok
				|> int_of_string_opt
				|> map (fun n -> n :: st)
				|> to_result ~none:"Invalid Token")
	in
	line
	|> String.split_on_char ' '
	|> List.fold_left (fun st tok -> Result.bind st (step tok)) (Ok [])
	|> function
	| Ok [ x ] -> Int.to_string x
	| Error e -> e
	| _ -> "Invalid Input"

let read () =
	match read_line () with
	| s -> Some (String.trim s)
	| exception Sys.Break -> None

let () =
	Sys.catch_break true;
	Seq.of_dispenser read |> Seq.map eval |> Seq.iter print_endline
