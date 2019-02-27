{-# language KindSignatures #-}

module EffectZoo.Scenario.BigStack.SimpleEffects.Identity where

import           Control.Effects

data Identity (m :: * -> *) = Identity

runIdentity :: RuntimeImplemented Identity m a -> m a
runIdentity = implement Identity
