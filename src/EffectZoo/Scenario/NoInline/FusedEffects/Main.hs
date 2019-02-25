module EffectZoo.Scenario.NoInline.FusedEffects.Main where

import           Control.Effect
import           Control.Monad
import           EffectZoo.Scenario.NoInline.FusedEffects.Increment
import           EffectZoo.Scenario.NoInline.FusedEffects.Program

increments :: Int -> IO Int
increments = runM . runIncrement . program
