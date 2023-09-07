module Main where

import Text.Parsec (letter)
import Text.Parsec.Char
import Text.Parsec.Token
import Data.Functor.Identity (Identity)

main :: IO ()
main = putStrLn "Hello, Haskell!"

newtype Name = Name String

newtype Length = Length Int

data Direction = North | South | East | West

newtype SpeedLimit = SpeedLimit Int

data Street = Street
  { name :: Name,
    length :: Length,
    direction :: Direction,
    speedLimit :: SpeedLimit
  }

lexer :: GenTokenParser String u Identity
lexer = makeTokenParser $ 
  LanguageDef
    { commentStart = "[!]",
      commentEnd = "[!]",
      commentLine = "--",
      nestedComments = False,
      reservedNames = ["street", "direction", "length", "speed-limit"],
      reservedOpNames = ["<>"],
      caseSensitive = False,
      identStart = letter,
      identLetter = alphaNum,
      opStart = oneOf "",
      opLetter = oneOf ""
    }
