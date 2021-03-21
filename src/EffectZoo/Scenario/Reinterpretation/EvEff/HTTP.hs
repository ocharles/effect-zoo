{-# language FlexibleContexts #-}
module EffectZoo.Scenario.Reinterpretation.EvEff.HTTP where

import Control.Ev.Eff
import Control.Ev.Util

newtype HTTP e ans = HTTP
  { httpGETOp :: Op String String e ans
  }

httpGET :: HTTP :? e => String -> Eff e String
httpGET = perform httpGETOp

mockResponses :: Eff (HTTP :* e) a -> Eff (Reader String :* e) a
mockResponses =
  handlerHide HTTP { httpGETOp = function (\_ -> perform ask ()) }
