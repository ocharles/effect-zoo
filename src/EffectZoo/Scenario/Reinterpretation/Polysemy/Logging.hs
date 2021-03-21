{-# language DataKinds, FlexibleContexts, GADTs, TypeOperators #-}
module EffectZoo.Scenario.Reinterpretation.Polysemy.Logging where

import Polysemy
import Polysemy.Writer

data Logging (m :: * -> *) a where
  LogMsg :: String -> Logging m ()
makeSem ''Logging

accumulateLogMessages :: Sem (Logging ': effs) a -> Sem (Writer [String] ': effs) a
accumulateLogMessages = reinterpret $ \(LogMsg m) -> tell [m]
