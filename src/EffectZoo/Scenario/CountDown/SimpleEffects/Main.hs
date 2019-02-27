module EffectZoo.Scenario.CountDown.SimpleEffects.Main where

import           Control.Effects
import           Data.Functor.Identity
import           EffectZoo.Scenario.CountDown.SimpleEffects.Program
import           EffectZoo.Scenario.CountDown.SimpleEffects.IntState

countDown :: Int -> (Int, Int)
countDown initial = runIdentity (runIntState initial program)
