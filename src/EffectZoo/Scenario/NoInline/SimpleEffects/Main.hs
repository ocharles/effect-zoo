{-# language FlexibleContexts #-}

module EffectZoo.Scenario.NoInline.SimpleEffects.Main where

import           Control.Effects
import           Control.Monad
import           EffectZoo.Scenario.NoInline.SimpleEffects.Increment
import           EffectZoo.Scenario.NoInline.SimpleEffects.Program

increments :: Int -> IO ()
increments = runIncrement . program
{-# NOINLINE increments #-}
