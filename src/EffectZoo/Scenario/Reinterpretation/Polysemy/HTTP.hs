{-# language DataKinds, FlexibleContexts, GADTs, TypeOperators #-}
module EffectZoo.Scenario.Reinterpretation.Polysemy.HTTP where

import Polysemy
import Polysemy.Reader

data HTTP (m :: * -> *) a where
  HttpGET :: String -> HTTP m String
makeSem ''HTTP

mockResponses :: Sem (HTTP ': effs) a -> Sem (Reader String ': effs) a
mockResponses = reinterpret $ \(HttpGET _path) -> ask
