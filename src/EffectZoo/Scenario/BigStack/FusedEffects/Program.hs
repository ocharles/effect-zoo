{-# LANGUAGE FlexibleContexts #-}

module EffectZoo.Scenario.BigStack.FusedEffects.Program where

import "fused-effects" Control.Algebra
import "fused-effects" Control.Effect.Reader
import "fused-effects" Control.Effect.State
import           Control.Monad

program
  :: (Has (Reader Int) sig m, Has (State Int) sig m)
  => m ()
program = do
  n <- ask
  replicateM_ n (modify (+ n))
