{-# language FlexibleContexts #-}

module EffectZoo.Scenario.BigStack.FusedEffects.Program where

import Control.Monad
import Control.Effect
import Control.Effect.Reader
import Control.Effect.State


program :: ( Member ( Reader Int ) sig, Member ( State Int ) sig, Carrier sig m, Monad m ) => m ()
program = do
  n <- ask
  replicateM_ n ( modify ( + n ) )
