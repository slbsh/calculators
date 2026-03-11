#!/usr/bin/env runhaskell

import Control.Monad (foldM)
import System.IO (isEOF)
import Text.Read (readMaybe)

process stack token =
  case readMaybe token of
    Just x -> Right (x : stack)
    Nothing -> do
      op <- case token of
        "+" -> Right (+)
        "-" -> Right (-)
        "*" -> Right (*)
        "/" -> Right quot
        _ -> Left "Invalid Token"

      case stack of
        b : a : rest -> Right (op a b : rest)
        _ -> Left "Too Few Arguments"

eval line = do
  stack <- foldM process [] (words line)
  case stack of
    [x] -> Right x
    _ -> Left "Invalid Input"

main = do
  eof <- isEOF
  if eof
    then return ()
    else do
      line <- getLine
      case eval line of
        Left e -> putStrLn e
        Right x -> print x
      main
