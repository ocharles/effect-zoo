{-# LANGUAGE DataKinds, FlexibleContexts, GADTs, TypeOperators #-}

module EffectZoo.Scenario.FileSizes.EvEff.Logging where

import           Control.Ev.Eff
import           Control.Ev.Monad
import           Control.Monad.IO.Class
import           Data.IORef
import qualified EffectZoo.Scenario.FileSizes.Shared
                                               as Shared

newtype Logging e ans = Logging { logMsgOp :: Op String () e ans }

logMsg :: Logging :? e => String -> Eff e ()
logMsg = perform logMsgOp

logToIORef :: IOEff :? e => IORef [String] -> Eff (Logging :* e) a -> Eff e a
logToIORef r =
  handler (Logging { logMsgOp = function (performIO . Shared.logToIORef r) })
