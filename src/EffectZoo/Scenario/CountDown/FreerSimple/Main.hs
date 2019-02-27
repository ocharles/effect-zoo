module EffectZoo.Scenario.CountDown.FreerSimple.Main where

import           Control.Monad.Freer
import           EffectZoo.Scenario.CountDown.FreerSimple.Program
import           EffectZoo.Scenario.CountDown.FreerSimple.IntState

countDown :: Int -> (Int, Int)
countDown initial = run (runState initial program)
