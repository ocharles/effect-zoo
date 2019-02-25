{-# language DataKinds, FlexibleContexts, GADTs, TypeOperators #-}
module EffectZoo.Scenario.Reinterpretation.FreerSimple.Logging where

import Control.Monad.Freer
import Control.Monad.Freer.Writer

data Logging a where
  LogMsg :: String -> Logging ()


logMsg :: Member Logging effs => String -> Eff effs ()
logMsg = send . LogMsg


accumulateLogMessages :: Eff ( Logging ': effs ) a -> Eff ( Writer [String] ': effs ) a
accumulateLogMessages =
  reinterpret $ \( LogMsg m ) -> tell [m]
