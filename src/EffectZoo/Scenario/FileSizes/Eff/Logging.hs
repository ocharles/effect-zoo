{-# LANGUAGE DataKinds, FlexibleContexts, GADTs, TypeOperators #-}

module EffectZoo.Scenario.FileSizes.Eff.Logging where

import           Control.Effect
import           Control.Effect
import           Data.IORef
import qualified EffectZoo.Scenario.FileSizes.Shared
                                               as Shared

data Logging :: Effect where
  LogMsg :: String -> Logging m ()

logMsg :: Logging :< effs => String -> Eff effs ()
logMsg = send . LogMsg

logToIORef
  :: IOE :< effs
  => IORef [String]
  -> Eff (Logging ': effs) a
  -> Eff effs a
logToIORef r = handle $ \(LogMsg m) -> liftH $ liftIO $ Shared.logToIORef r m
