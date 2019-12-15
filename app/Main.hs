module Main where

import Data.Maybe (fromMaybe)
import System.Environment (getArgs)

import qualified Day1 as Day1
import qualified Day2 as Day2

type Solution = (String -> String)

solutions :: [(String, Solution)]
solutions =
  [ ("day1", Day1.solve)
  , ("day2", Day2.solve)
  ]

getSolution :: String -> Solution
getSolution day = fromMaybe (const $ "no solution for: " <> day) (lookup day solutions)

main :: IO ()
main = do
  day <- head <$> getArgs
  inp <- readFile $ "inputs/" <> day
  print $ getSolution day $ inp
