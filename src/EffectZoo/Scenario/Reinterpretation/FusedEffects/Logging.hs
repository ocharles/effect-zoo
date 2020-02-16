{-# language KindSignatures, FlexibleContexts, TypeOperators, FlexibleInstances, MultiParamTypeClasses, UndecidableInstances, DeriveFunctor #-}
module EffectZoo.Scenario.Reinterpretation.FusedEffects.Logging where

import           Data.Coerce
import           Control.Effect
import           Control.Effect.Carrier
import           Control.Effect.Sum
import           Control.Effect.Writer

data Logging (m :: * -> *) k = LogMsg String k
 deriving (Functor)

logMsg :: (Carrier sig m, Member Logging sig) => String -> m ()
logMsg msg = send (LogMsg msg (ret ()))

instance Effect Logging where
  handle state handler (LogMsg msg k) = LogMsg msg (handler (k <$ state))

instance HFunctor Logging where
  hmap _ = coerce

newtype WriterLoggingC m a = WriterLoggingC { runWriterLoggingC :: m a }

instance (Carrier sig m, Effect sig, Member (Writer [ String ]) sig, Monad m) => Carrier (Logging :+: sig) (WriterLoggingC m) where
  ret = WriterLoggingC . ret
  eff  =
    WriterLoggingC
      . handleSum
          ( eff . handleCoercible )
          ( \( LogMsg msg k ) -> tell [ msg ] >> runWriterLoggingC k )

accumulateLogMessages
  :: (Monad m, Carrier sig m, Effect sig, Member (Writer [String]) sig)
  => Eff (WriterLoggingC m) a
  -> m a
accumulateLogMessages m = runWriterLoggingC (interpret m)
