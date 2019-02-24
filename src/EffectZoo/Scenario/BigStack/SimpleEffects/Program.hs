{-# language DataKinds, FlexibleContexts #-}

module EffectZoo.Scenario.BigStack.SimpleEffects.Program where

import Control.Monad
import Control.Effects
import Control.Effects.State
import Control.Effects.Reader


program :: MonadEffects '[ State Int, ReadEnv Int ] m => m ()
program = do
  n <- readEnv
  replicateM_ n ( modifyState ( + n ) )
