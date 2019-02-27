{-# language GADTs, FlexibleContexts, TypeOperators, DataKinds #-}
module EffectZoo.Scenario.BigStack.FreerSimple.Identity where

import           Control.Monad.Freer

data Identity a where
  Noop :: Identity ()

noop :: Member Identity effs => Eff effs ()
noop = send Noop

runIdentity :: Eff (Identity ': effs) a -> Eff effs a
runIdentity = interpret $ \Noop -> return ()
