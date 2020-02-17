{-# LANGUAGE FlexibleContexts #-}

module EffectZoo.Scenario.BigStack.Eff.Program where

import "eff" Control.Effect
import Control.Monad

program :: (Reader Int :< effs, State Int :< effs) => Eff effs ()
program = do
  n <- ask
  replicateM_ n (modify (+ n))
