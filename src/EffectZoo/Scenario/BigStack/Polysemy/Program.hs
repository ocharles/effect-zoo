{-# LANGUAGE FlexibleContexts #-}

module EffectZoo.Scenario.BigStack.Polysemy.Program where

import Control.Monad
import Polysemy
import Polysemy.Reader
import Polysemy.State

program :: (Member (Reader Int) effs, Member (State Int) effs) => Sem effs ()
program = do
  n <- ask
  replicateM_ n (modify (+ n))
