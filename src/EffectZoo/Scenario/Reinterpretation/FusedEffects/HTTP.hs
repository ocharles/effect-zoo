{-# language KindSignatures, FlexibleContexts, DeriveFunctor, TypeOperators, FlexibleInstances, MultiParamTypeClasses, UndecidableInstances #-}
module EffectZoo.Scenario.Reinterpretation.FusedEffects.HTTP where

import GHC.Generics (Generic1)
import "fused-effects" Control.Algebra
import "fused-effects" Control.Effect.Sum
import "fused-effects" Control.Effect.Reader

data HTTP m k = GET String (String -> m k)
  deriving (Functor, Generic1)

instance Effect HTTP
instance HFunctor HTTP

httpGET :: Has HTTP sig m => String -> m String
httpGET url = send (GET url pure)

newtype ReaderHTTPC m a = ReaderHTTPC { runReaderHTTPC :: m a }
  deriving (Functor, Applicative, Monad)

instance (Monad m, Has (Reader String) sig m) => Algebra (HTTP :+: sig) (ReaderHTTPC m) where
  alg (L (GET _path k)) = ReaderHTTPC ask >>= k
  alg (R other) = ReaderHTTPC (alg (handleCoercible other))

mockResponses :: ReaderHTTPC m a -> m a
mockResponses = runReaderHTTPC
