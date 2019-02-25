{-# LANGUAGE FlexibleContexts #-}

module EffectZoo.Scenario.CountDown.SimpleEffects.Program where

import           Control.Effects
import           Control.Effects.State

program :: MonadEffect (State Int) m => m Int
program = do
  n <- getState
  if n <= 0
    then pure n
    else do
      setState (n - 1)
      program
