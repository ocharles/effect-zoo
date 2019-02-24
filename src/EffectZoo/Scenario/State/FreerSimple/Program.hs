{-# LANGUAGE FlexibleContexts #-}

module EffectZoo.Scenario.State.FreerSimple.Program where

import Control.Monad.Freer
import Control.Monad.Freer.State

program :: Member (State Int) effects => Eff effects Int
program = do
  n <- get
  if n <= 0
    then pure n
    else do
      put (n - 1)
      program
