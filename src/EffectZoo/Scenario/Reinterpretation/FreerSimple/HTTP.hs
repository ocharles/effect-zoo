{-# language DataKinds, FlexibleContexts, GADTs, TypeOperators #-}
module EffectZoo.Scenario.Reinterpretation.FreerSimple.HTTP where

import Control.Monad.Freer
import Control.Monad.Freer.Reader

data HTTP a where
  GET :: String -> HTTP String


httpGET :: Member HTTP effs => String -> Eff effs String
httpGET = send . GET


mockResponses :: Eff ( HTTP ': effs ) a -> Eff ( Reader String ': effs ) a
mockResponses =
  reinterpret $ \( GET _path ) -> ask
