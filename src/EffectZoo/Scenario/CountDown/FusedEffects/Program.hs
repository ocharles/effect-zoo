{-# LANGUAGE FlexibleContexts #-}

module EffectZoo.Scenario.CountDown.FusedEffects.Program where

import "fused-effects" Control.Algebra
import "fused-effects" Control.Effect.State

program :: Has (State Int) sig m => m Int
program = do
  n <- get
  if n <= 0
    then pure n
    else do
      put (n - 1)
      program
