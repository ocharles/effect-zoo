{-# language KindSignatures, FlexibleContexts, TypeOperators, FlexibleInstances, MultiParamTypeClasses, UndecidableInstances, DeriveFunctor #-}
module EffectZoo.Scenario.Reinterpretation.FusedEffects.Logging where

import GHC.Generics (Generic1)
import "fused-effects" Control.Algebra
import "fused-effects" Control.Effect.Sum
import "fused-effects" Control.Effect.Writer

data Logging m k = LogMsg String (m k)
  deriving (Functor, Generic1)

logMsg :: Has Logging sig m => String -> m ()
logMsg msg = send (LogMsg msg (pure ()))

instance HFunctor Logging
instance Effect Logging

newtype WriterLoggingC m a = WriterLoggingC { runWriterLoggingC :: m a }
  deriving (Functor, Applicative, Monad)

instance Has (Writer [String]) sig m => Algebra (Logging :+: sig) (WriterLoggingC m) where
  alg (L (LogMsg msg k)) = WriterLoggingC (tell [msg]) >> k
  alg (R other) = WriterLoggingC (alg (handleCoercible other))

accumulateLogMessages
  :: Has (Writer [String]) sig m
  => WriterLoggingC m a
  -> m a
accumulateLogMessages = runWriterLoggingC
