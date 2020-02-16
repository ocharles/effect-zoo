{-# language KindSignatures, FlexibleContexts, DeriveFunctor, TypeOperators, FlexibleInstances, MultiParamTypeClasses, UndecidableInstances #-}
module EffectZoo.Scenario.Reinterpretation.FusedEffects.HTTP where

import           Control.Effect
import           Control.Effect.Carrier
import           Control.Effect.Sum
import           Control.Effect.Reader
import           Data.Coerce

data HTTP (m :: * -> *) k = GET String ( String -> k)
  deriving (Functor)

instance Effect HTTP where
  handle state handler (GET path k) = GET path (handler . (<$ state) . k)

httpGET :: (Carrier sig m, Member HTTP sig) => String -> m String
httpGET url = send (GET url ret)

instance HFunctor HTTP where
  hmap _ = coerce

newtype ReaderHTTPC m a = ReaderHTTPC { runReaderHTTPC :: m a }

instance (Carrier sig m, Effect sig, Member (Reader String) sig, Monad m) => Carrier (HTTP :+: sig) (ReaderHTTPC m) where
  ret = ReaderHTTPC . ret
  eff  =
    ReaderHTTPC
      . handleSum
          ( eff . handleCoercible )
          ( \( GET _path k ) -> ask >>= runReaderHTTPC . k )

mockResponses
  :: (Monad m, Carrier sig m, Effect sig, Member (Reader String) sig)
  => Eff (ReaderHTTPC m) a
  -> m a
mockResponses m = runReaderHTTPC (interpret m)
