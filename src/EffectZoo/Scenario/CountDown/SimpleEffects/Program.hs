{-# LANGUAGE FlexibleContexts #-}

module EffectZoo.Scenario.CountDown.SimpleEffects.Program where

import           Control.Effects
import           EffectZoo.Scenario.CountDown.SimpleEffects.IntState

program :: MonadEffect IntState m => m Int
program = do
  n <- get
  if n <= 0
    then pure n
    else do
      put (n - 1)
      program
