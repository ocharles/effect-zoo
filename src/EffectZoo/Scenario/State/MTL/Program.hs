{-# LANGUAGE FlexibleContexts #-}

module EffectZoo.Scenario.State.MTL.Program where

import           Control.Monad.State                      ( MonadState
                                                          , get
                                                          , put
                                                          )

program :: MonadState Int m => m Int
program = do
  n <- get
  if n <= 0
    then pure n
    else do
      put (n - 1)
      program
