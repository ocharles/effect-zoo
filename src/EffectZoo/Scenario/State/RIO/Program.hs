{-# LANGUAGE FlexibleContexts #-}

module EffectZoo.Scenario.State.RIO.Program where

import           Control.Monad.State.Class
import           RIO

program :: HasStateRef Int env => RIO env Int
program = do
  n <- get
  if n <= 0
    then pure n
    else do
      put (n - 1)
      program
