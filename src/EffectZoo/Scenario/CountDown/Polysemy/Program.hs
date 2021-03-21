{-# OPTIONS_GHC -dsuppress-type-signatures #-}
{-# LANGUAGE FlexibleContexts #-}

module EffectZoo.Scenario.CountDown.Polysemy.Program where

import Polysemy
import Polysemy.State

program :: Member (State Int) eff => Sem eff Int
program = do
  n <- get
  if n <= 0
    then pure n
    else do
      put (n - 1)
      program
