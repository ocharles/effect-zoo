module EffectZoo.Scenario.CountDown.FreerSimple.Main where

import           Control.Monad.Freer
import           Control.Monad.Freer.State
import           EffectZoo.Scenario.CountDown.FreerSimple.Program

countDown :: Int -> (Int, Int)
countDown initial = run (runState initial program)
