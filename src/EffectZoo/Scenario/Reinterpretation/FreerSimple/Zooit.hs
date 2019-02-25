{-# language DataKinds, FlexibleContexts, GADTs, TypeOperators #-}
module EffectZoo.Scenario.Reinterpretation.FreerSimple.Zooit where

import Control.Monad.Freer
import EffectZoo.Scenario.Reinterpretation.FreerSimple.Logging
import EffectZoo.Scenario.Reinterpretation.FreerSimple.HTTP

data Zooit a where
  ListScenarios :: Zooit [String]


listScenarios :: Member Zooit effs => Eff effs [String]
listScenarios = send ListScenarios


toLoggedHTTP :: Eff ( Zooit ': effs ) a -> Eff ( HTTP ': Logging ': effs ) a
toLoggedHTTP =
  reinterpret2 $ \ListScenarios -> do
    logMsg "Fetching a list of scenarios"
    lines <$> httpGET "/scenarios"
