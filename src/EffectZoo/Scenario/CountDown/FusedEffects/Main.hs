module EffectZoo.Scenario.CountDown.FusedEffects.Main where

import           Control.Effect
import           Control.Effect.Void
import           EffectZoo.Scenario.CountDown.FusedEffects.IntState
import           EffectZoo.Scenario.CountDown.FusedEffects.Program

countDown :: Int -> (Int, Int)
countDown initial = run (runState initial program)
