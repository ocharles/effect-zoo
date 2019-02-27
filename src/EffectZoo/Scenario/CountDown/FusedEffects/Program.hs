{-# LANGUAGE FlexibleContexts #-}

module EffectZoo.Scenario.CountDown.FusedEffects.Program where

import           Control.Effect
import           EffectZoo.Scenario.CountDown.FusedEffects.IntState

program :: (Member IntState sig, Carrier sig m, Monad m) => m Int
program = do
  n <- get
  if n <= 0
    then pure n
    else do
      put (n - 1)
      program
