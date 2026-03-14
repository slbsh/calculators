#!/usr/bin/env runhaskell

import Control.Monad (foldM, guard)
import System.IO (isEOF)
import Text.Read (readMaybe)

process stack token =
  case readMaybe token of
    Just x  -> Right $ x : stack
    Nothing -> readOp token >>= evalOpOnStack
  where
    readOp t = case t of
      "+" -> Right (+)
      "-" -> Right (-)
      "*" -> Right (*)
      "/" -> Right quot
      _   -> Left "Invalid Token"

    evalOpOnStack op = case stack of
      (b : a : rest) -> Right $ op a b : rest
      _              -> Left "Too Few Arguments"

eval line = do
  stack <- foldM process [] (words line)
  case stack of
    [x] -> Right x
    _   -> Left "Invalid Input"

main = do
  isEOF >>= guard . not
  line <- getLine
  case eval line of
    Left e  -> putStrLn e
    Right x -> print x
  main
