{-# LANGUAGE DataKinds, FlexibleContexts, GADTs, TypeOperators #-}

module EffectZoo.Scenario.FileSizes.FreerSimple.Logging where

import Control.Monad.Freer
import Control.Monad.IO.Class
import Data.IORef
import qualified EffectZoo.Scenario.FileSizes.Shared as Shared

data Logging a where
  LogMsg :: String -> Logging ()

logMsg :: Member Logging effs => String -> Eff effs ()
logMsg = send . LogMsg

logToIORef ::
     LastMember IO effs
  => IORef [String]
  -> Eff (Logging ': effs) a
  -> Eff effs a
logToIORef r = interpret (\(LogMsg m) -> sendM (Shared.logToIORef r m))
