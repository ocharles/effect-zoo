module EffectZoo.Scenario.State.RIO.Main where

import           EffectZoo.Scenario.State.RIO.Program
import           RIO

countDown :: Int -> IO (Int, Int)
countDown initial = do
  ref <- newSomeRef initial
  n   <- runRIO ref program
  s   <- readSomeRef ref
  return (n, s)
