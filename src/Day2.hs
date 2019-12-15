module Day2 where

import qualified Data.Vector as V
import Data.Vector (Vector, (//))
import Control.Monad.State
import Control.Lens
import Data.List.Split (splitOn)
import Control.Monad.Except (ExceptT, runExceptT, throwError)

type Memory = Vector Int
type Instructions = [Int]
type Program = ExceptT String (State Memory) Int

solve :: String -> String
solve = show . part1 . parseInstructions

part1 :: Instructions -> Either String Int
part1 = runProgram part1Program

parseInstructions :: String -> Instructions
parseInstructions = fmap read . splitOn "," 

allocateMem :: Instructions -> Memory
allocateMem = V.fromList

restore :: Memory -> Memory
restore memory = memory // [(1, 12), (2, 2)]

runProgram :: Program -> Instructions -> Either String Int 
runProgram program instructions = evalState (runExceptT program) mem
  where mem = restore $ allocateMem instructions

writeTo :: Int -> Int -> Program 
writeTo i v = modify (\s -> s & ix i .~ v) >> readFrom 0

readFrom :: Int -> Program 
readFrom i = gets (\s -> s V.! i)

readPointerFrom :: Int -> Program
readPointerFrom = readFrom >=> readFrom

part1Program :: Program
part1Program = runOpCode 0
  where
    runOpCode pos = do
      opc <- readFrom pos
      case opc of
        1  -> runBinOp (+)
        2  -> runBinOp (*)
        99 -> readFrom 0
        _  -> throwError $ "unexpected optcode at pos: " <> show pos
        where
          runBinOp binOp = do
            val1 <- readPointerFrom $ pos+1
            val2 <- readPointerFrom $ pos+2
            dest <- readFrom $ pos+3
            void $  writeTo dest $ val1 `binOp` val2
            runOpCode $ pos+4
