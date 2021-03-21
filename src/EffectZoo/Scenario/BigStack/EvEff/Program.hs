{-# LANGUAGE FlexibleContexts #-}

module EffectZoo.Scenario.BigStack.EvEff.Program where

import           Control.Ev.Eff
import           Control.Ev.Util
import           Control.Monad

program :: (State Int :? e, Reader Int :? e) => Eff e ()
program = do
  n <- perform ask ()
  replicateM_ n (perform get () >>= \x -> perform put (x + n))
