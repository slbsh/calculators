#!/usr/bin/env -S sh -c 'f=$(mktemp --suffix=.fsx); tail +2 $0 > $f; dotnet fsi --warn:0 $f'
open System

while true do
   let stack = System.Collections.Generic.Stack<int>()

   for t in Console.ReadLine().Split() do
      match Int32.TryParse t with
      | true, n -> stack.Push n
      | _ when stack.Count < 2 -> printfn "Too Few Arguments"
      | _ when not ([| "+"; "-"; "*"; "/" |] |> Array.contains t) ->
         printfn "Invalid Token"
      | _ ->
         let b, a = stack.Pop(), stack.Pop()
         stack.Push(match t with
                     | "+" -> a + b | "-" -> a - b
                     | "*" -> a * b | _ -> a / b)

   if stack.Count = 1 then
      printfn "%d" (stack.Pop())
   else printfn "Invalid Input"
