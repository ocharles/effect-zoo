{-# language DeriveAnyClass, GADTs, DeriveGeneric, FlexibleContexts, NoMonomorphismRestriction #-}

module EffectZoo.Scenario.Reinterpretation.SimpleEffects.Logging where

import           Control.Effects
import           Control.Effects.State
import           GHC.Generics

data Logging m =
  Logging
    { _logMsg :: String -> m ()
    }
  deriving (Generic, Effect)

logMsg :: MonadEffect Logging m => String -> m ()
Logging logMsg = effect


accumulateLogMessages
  :: MonadEffect (State [String]) m => RuntimeImplemented Logging m a -> m a
accumulateLogMessages =
  implement Logging {_logMsg = \m -> modifyState (++ [m])}
