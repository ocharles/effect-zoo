{-# LANGUAGE FlexibleContexts #-}

module EffectZoo.Scenario.CountDown.EvEff.Program where

import           Control.Ev.Eff
import           Control.Ev.Util

program :: (State Int :? e) => Eff e Int
program = do
  n <- perform get ()
  if n <= 0
    then pure n
    else do
      perform put (n - 1)
      program
