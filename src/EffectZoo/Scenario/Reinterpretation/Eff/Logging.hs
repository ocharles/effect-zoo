{-# language DataKinds, FlexibleContexts, GADTs, TypeOperators #-}
module EffectZoo.Scenario.Reinterpretation.Eff.Logging where

import Control.Effect

data Logging :: Effect where
  LogMsg :: String -> Logging m ()

logMsg :: Logging :< effs => String -> Eff effs ()
logMsg = send . LogMsg

accumulateLogMessages :: Writer [String] :< effs => Eff (Logging ': effs) a -> Eff effs a
accumulateLogMessages = handle $ \(LogMsg m) -> liftH $ tell [m]
