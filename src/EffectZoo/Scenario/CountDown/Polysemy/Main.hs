module EffectZoo.Scenario.CountDown.Polysemy.Main where

import Polysemy
import Polysemy.State
import EffectZoo.Scenario.CountDown.Polysemy.Program

countDown :: Int -> (Int, Int)
countDown initial = run (runState initial program)
