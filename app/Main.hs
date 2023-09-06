module Main where

import Text.Parsec (letter)
import Text.Parsec.Char
import Text.Parsec.Token

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

lexer :: LanguageDef String
lexer =
  LanguageDef
    { commentStart = "",
      commentEnd = "",
      commentLine = "<!>",
      nestedComments = False,
      reservedNames = ["street", "direction", "length", "speed-limit"],
      reservedOpNames = [],
      caseSensitive = False,
      identStart = letter,
      identLetter = letter,
      opStart = oneOf "<:",
      opLetter = oneOf ">:"
    }
