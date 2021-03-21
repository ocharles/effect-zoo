{-# language GADTs, FlexibleContexts, TypeOperators, DataKinds #-}
module EffectZoo.Scenario.BigStack.Polysemy.Identity where

import Polysemy

data Identity (m :: * -> *) a where
  Noop :: Identity m ()
makeSem ''Identity

runIdentity :: Sem (Identity ': effs) a -> Sem effs a
runIdentity = interpret $ \Noop -> return ()
