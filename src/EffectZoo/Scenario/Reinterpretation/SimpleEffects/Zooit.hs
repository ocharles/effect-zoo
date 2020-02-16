{-# language DeriveAnyClass, DataKinds, GADTs, DeriveGeneric, FlexibleContexts, NoMonomorphismRestriction #-}

module EffectZoo.Scenario.Reinterpretation.SimpleEffects.Zooit where

import           Control.Effects
import           GHC.Generics
import           EffectZoo.Scenario.Reinterpretation.SimpleEffects.Logging
import           EffectZoo.Scenario.Reinterpretation.SimpleEffects.HTTP

data Zooit m =
  Zooit
    { _listScenarios :: m [String]
    }
  deriving (Generic, Effect)

listScenarios :: MonadEffect Zooit m => m [String]
Zooit listScenarios = effect


toLoggedHTTP
  :: MonadEffects '[Logging, HTTP] m => RuntimeImplemented Zooit m a -> m a
toLoggedHTTP = implement Zooit
  { _listScenarios = do
    logMsg "Fetching a list of scenarios"
    lines <$> httpGET "/scenarios"
  }
