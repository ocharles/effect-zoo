{-# LANGUAGE FlexibleContexts #-}

module EffectZoo.Scenario.CountDown.FreerSimple.Program where

import           Control.Monad.Freer
import           EffectZoo.Scenario.CountDown.FreerSimple.IntState

program :: Member IntState effects => Eff effects Int
program = do
  n <- get
  if n <= 0
    then pure n
    else do
      put (n - 1)
      program
