{-# language DeriveAnyClass, DeriveGeneric, FlexibleContexts, NoMonomorphismRestriction #-}
module EffectZoo.Scenario.FileSizes.SimpleEffects.Logging where

import Data.IORef
import Control.Effects
import Control.Monad.IO.Class
import qualified EffectZoo.Scenario.FileSizes.Shared as Shared
import GHC.Generics

data Logging m = Logging { _logMsg :: String -> m () }
  deriving ( Generic, Effect )

logMsg :: MonadEffect Logging m => String -> m ()
Logging logMsg = effect


logToIORef :: MonadIO m => IORef [String] -> RuntimeImplemented Logging m a -> m a
logToIORef ref =
  implement
    Logging
      { _logMsg = \m ->
          liftIO ( Shared.logToIORef ref m )
      }
