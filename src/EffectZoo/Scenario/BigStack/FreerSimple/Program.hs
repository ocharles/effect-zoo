{-# language FlexibleContexts #-}

module EffectZoo.Scenario.BigStack.FreerSimple.Program where

import Control.Monad
import Control.Monad.Freer
import Control.Monad.Freer.Reader
import Control.Monad.Freer.State


program :: ( Member ( Reader Int ) effs, Member ( State Int ) effs ) => Eff effs ()
program = do
  n <- ask
  replicateM_ n ( modify ( + n ) )
