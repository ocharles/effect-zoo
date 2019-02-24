{-# LANGUAGE FlexibleContexts #-}

module EffectZoo.Scenario.BigStack.MTL.Program where

import Control.Monad
import Control.Monad.Reader.Class
import Control.Monad.State.Class

program :: (MonadReader Int m, MonadState Int m) => m ()
program = do
  n <- ask
  replicateM_ n (modify (+ n))
