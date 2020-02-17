{-# LANGUAGE DataKinds, FlexibleContexts, GADTs, TypeOperators #-}

module EffectZoo.Scenario.FileSizes.Polysemy.Logging where

import Polysemy
import Control.Monad.IO.Class
import Data.IORef
import qualified EffectZoo.Scenario.FileSizes.Shared
                                               as Shared

data Logging (m :: * -> *) a where
  LogMsg :: String -> Logging m ()
makeSem ''Logging

logToIORef
  :: Member (Embed IO) effs
  => IORef [String]
  -> Sem (Logging ': effs) a
  -> Sem effs a
logToIORef r = interpret (\(LogMsg m) -> embed (Shared.logToIORef r m))
