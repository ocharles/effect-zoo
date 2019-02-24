module EffectZoo.Scenario.State.FreerSimple.Main where

import           Control.Monad.Freer
import           Control.Monad.Freer.State
import           EffectZoo.Scenario.State.FreerSimple.Program

countDown :: Int -> (Int, Int)
countDown initial = run (runState initial program)
