module Day2 where

import           Data.List.Split                ( splitOn )
import           OpCodeProgram
import           Data.Vector                    ( Vector )
import qualified Data.Vector                   as V
import           Control.Monad.Except

part1 :: OpCodeProgram ()
part1 = forever $ do
  opc <- readFrom 0
  case parseOpCode opc of
    Terminate   -> end
    BinOp binOp -> do
      val1 <- readFromPtr 1
      val2 <- readFromPtr 2
      dest <- readFrom 3
      writeTo dest (val1 `binOp` val2)
      jump
    NotSupported -> error "unsupported opcode"

parseInstructions :: String -> [Int]
parseInstructions = fmap read . splitOn ","

runPart1 :: Vector Int -> Int
runPart1 inp = runProgram part1 inp

solve :: String -> String
solve = show . runPart1 . restoreMemory . V.fromList . parseInstructions
