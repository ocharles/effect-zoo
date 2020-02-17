{-# OPTIONS_GHC -dsuppress-type-signatures #-}
{-# LANGUAGE FlexibleContexts #-}

module EffectZoo.Scenario.CountDown.Eff.Program where

import "eff" Control.Effect

program :: State Int :< eff => Eff eff Int
program = do
  n <- get
  if n <= 0
    then pure n
    else do
      put (n - 1)
      program
