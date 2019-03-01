module EffectZoo.Scenario.CountDown.SimpleEffects.Main where

import           Control.Effects
import           Control.Effects.State
import           Data.Functor.Identity
import           EffectZoo.Scenario.CountDown.SimpleEffects.Program

countDown :: Int -> (Int, Int)
countDown initial = runIdentity
  (implementStateViaStateT
    initial
    (program >>= \x -> getState >>= \y -> return (x, y))
  )
