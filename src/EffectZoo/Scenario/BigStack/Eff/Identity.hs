{-# language GADTs, FlexibleContexts, TypeOperators, DataKinds #-}
module EffectZoo.Scenario.BigStack.Eff.Identity where

import "eff" Control.Effect

data Identity :: Effect where
  Noop :: Identity m ()

noop :: Identity :< effs => Eff effs ()
noop = send Noop

runIdentity :: Eff (Identity ': effs) a -> Eff effs a
runIdentity = handle $ \Noop -> return ()
