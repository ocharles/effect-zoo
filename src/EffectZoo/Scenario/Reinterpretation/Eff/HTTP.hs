{-# language DataKinds, FlexibleContexts, GADTs, TypeOperators #-}
module EffectZoo.Scenario.Reinterpretation.Eff.HTTP where

import Control.Effect

data HTTP :: Effect where
  GET :: String -> HTTP m String

httpGET :: HTTP :< effs => String -> Eff effs String
httpGET = send . GET

mockResponses :: Reader String :< effs => Eff (HTTP ': effs) a -> Eff effs a
mockResponses = handle $ \(GET _path) -> liftH ask
