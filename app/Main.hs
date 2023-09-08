{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Use <$>" #-}
module Main where

import Control.Applicative ((<|>))
import Text.Parsec (choice)
import Text.Parsec.Language (emptyDef)
import Text.Parsec.String (Parser)
import qualified Text.Parsec.Token as Tok

main :: IO ()
main = putStrLn "Hello, Haskell!"

newtype Natural = Natural Integer
  deriving (Show)

data Direction = North | South | East | West
  deriving (Show)

data Street = Street
  { name :: String,
    dir :: Direction,
    speedLimit :: Natural,
    length :: Natural
  }
  deriving (Show)

lexer :: Tok.TokenParser ()
lexer = Tok.makeTokenParser style
  where
    ops = []
    names = ["street", "going", "for", "at", "limit", "north", "south", "east", "west"]
    style =
      emptyDef
        { Tok.commentLine = "#",
          Tok.reservedOpNames = ops,
          Tok.reservedNames = names
        }

natural :: Parser Natural
natural = Natural <$> Tok.natural lexer

reserved :: String -> Parser ()
reserved = Tok.reserved lexer

identifier :: Parser String
identifier = Tok.identifier lexer

direction :: Parser Direction
direction =
  choice
    [ North <$ reserved "north",
      South <$ reserved "south",
      East <$ reserved "east",
      West <$ reserved "west"
    ]

street :: Parser Street
street =
  Street
    <$> identifier
    <* reserved "street"
    <* reserved "going"
    <*> direction
    <* reserved "for"
    <*> natural
    <* reserved "at limit"
    <*> natural
