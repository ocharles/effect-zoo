{-# LANGUAGE DeriveFunctor, ExistentialQuantification, FlexibleContexts, FlexibleInstances, LambdaCase, MultiParamTypeClasses, StandaloneDeriving, TypeOperators, UndecidableInstances, KindSignatures #-}
module EffectZoo.Scenario.BigStack.FusedEffects.Identity where

import GHC.Generics (Generic1)
import "fused-effects" Control.Algebra
import "fused-effects" Control.Effect.Sum

data Identity m k = Noop (m k)
  deriving (Functor, Generic1)

instance HFunctor Identity
instance Effect Identity

newtype IdentityC m a = IdentityC { runIdentity :: m a }
  deriving (Functor, Applicative, Monad)

instance Algebra sig m => Algebra (Identity :+: sig) (IdentityC m) where
  alg (L (Noop k)) = k
  alg (R other) = IdentityC (alg (handleCoercible other))
