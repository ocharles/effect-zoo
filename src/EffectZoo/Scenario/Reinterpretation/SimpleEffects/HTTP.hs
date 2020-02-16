{-# language GADTs, DeriveAnyClass, DeriveGeneric, FlexibleContexts, NoMonomorphismRestriction #-}

module EffectZoo.Scenario.Reinterpretation.SimpleEffects.HTTP where

import           Control.Effects
import           Control.Effects.Reader
import           GHC.Generics

data HTTP m =
  HTTP
    { _GET :: String -> m String
    }
  deriving (Generic, Effect)

httpGET :: MonadEffect HTTP m => String -> m String
HTTP httpGET = effect


mockResponses
  :: MonadEffect (ReadEnv String) m => RuntimeImplemented HTTP m a -> m a
mockResponses = implement HTTP {_GET = \_path -> readEnv}
