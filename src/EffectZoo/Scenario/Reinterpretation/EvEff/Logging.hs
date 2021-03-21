{-# language FlexibleContexts #-}
module EffectZoo.Scenario.Reinterpretation.EvEff.Logging where

import Control.Ev.Eff
import Control.Ev.Util

newtype Logging e ans = Logging { logMsgOp :: Op String () e ans }

logMsg :: Logging :? e => String -> Eff e ()
logMsg = perform logMsgOp

accumulateLogMessages :: Eff (Logging :* e) a -> Eff (Writer [String] :* e) a
accumulateLogMessages = handlerHide Logging
  { logMsgOp = function (perform tell . (:[])) }
