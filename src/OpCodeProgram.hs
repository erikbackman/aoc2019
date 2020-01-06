{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module OpCodeProgram where

import           Data.Vector                    ( Vector
                                                , (//)
                                                )
import           Control.Monad.State
import           Control.Lens
import           Control.Monad.Except

data ProgramState = ProgramState
  { _memory :: Vector Int
  , _zeroIx :: Int
  } deriving (Show)

makeLenses ''ProgramState

newtype OpCodeProgramM a = OpCodeProgramM
  { runOpCodeProgram :: State ProgramState a
  } deriving (Functor, Applicative, Monad, MonadState ProgramState)

type OpCodeProgram a = ExceptT () OpCodeProgramM a

data OpCode
  = BinOp (Int -> Int -> Int)
  | Terminate
  | NotSupported

readFrom_ :: Int -> OpCodeProgram Int
readFrom_ i = gets (\s -> s ^?! memory . ix i)

readFrom :: Int -> OpCodeProgram Int
readFrom i = gets (view zeroIx) >>= readFrom_ . (+ i)

readFromPtr :: Int -> OpCodeProgram Int
readFromPtr = readFrom >=> readFrom_

writeTo :: Int -> Int -> OpCodeProgram ()
writeTo i v = memory . ix i .= v

jumpN :: Int -> OpCodeProgram ()
jumpN n = zeroIx += n

jump :: OpCodeProgram ()
jump = jumpN 4

end :: OpCodeProgram ()
end = throwError ()

parseOpCode :: Int -> OpCode
parseOpCode 1  = BinOp (+)
parseOpCode 2  = BinOp (*)
parseOpCode 99 = Terminate
parseOpCode _  = NotSupported

restoreMemory :: Vector Int -> Vector Int
restoreMemory vec = vec // [(1, 12), (2, 2)]

runProgram :: OpCodeProgram () -> Vector Int -> Int
runProgram program input =
  execState (runOpCodeProgram $ runExceptT program) initState ^?! memory . ix 0
  where initState = ProgramState input 0
