{-# LANGUAGE DeriveFunctor, ExistentialQuantification, FlexibleContexts, FlexibleInstances, LambdaCase, MultiParamTypeClasses, StandaloneDeriving, TypeOperators, UndecidableInstances, KindSignatures #-}
module EffectZoo.Scenario.BigStack.FusedEffects.Identity where

import           Data.Coerce
import           Control.Effect.Carrier
import           Control.Effect.Sum
import           Control.Effect.Internal

data Identity (m :: * -> *) k
  = Noop k
  deriving (Functor)

instance HFunctor Identity where
  hmap _ = coerce

instance Effect Identity where
  handle state handler (Noop k) = Noop (handler (k <$ state))

newtype IdentityC m a = IdentityC { runIdentityC :: m a }

instance (Carrier sig m, Effect sig) => Carrier (Identity :+: sig) (IdentityC m) where
  ret = IdentityC . ret
  eff = IdentityC . handleSum (eff . handleCoercible) (\( Noop k ) -> runIdentityC k)

runIdentity :: (Effect sig, Carrier sig m) => Eff (IdentityC m) a -> m a
runIdentity m = runIdentityC (interpret m)
