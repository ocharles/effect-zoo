{-# LANGUAGE DataKinds, FlexibleContexts #-}

module EffectZoo.Scenario.BigStack.SimpleEffects.Program where

import           Control.Effects
import           Control.Effects.Reader
import           Control.Effects.State
import           Control.Monad

program :: MonadEffects '[State Int, ReadEnv Int] m => m ()
program = do
  n <- readEnv
  replicateM_ n (modifyState (+ n))
