{-# OPTIONS_GHC -dsuppress-module-prefixes #-}
{-# language DataKinds, FlexibleContexts, GADTs, TypeOperators #-}
module EffectZoo.Scenario.Reinterpretation.Eff.Zooit where

import Control.Effect
import EffectZoo.Scenario.Reinterpretation.Eff.Logging
import EffectZoo.Scenario.Reinterpretation.Eff.HTTP

data Zooit :: Effect where
  ListScenarios :: Zooit m [String]

listScenarios :: Zooit :< effs => Eff effs [String]
listScenarios = send ListScenarios

toLoggedHTTP :: (HTTP :< effs, Logging :< effs) => Eff (Zooit ': effs) a -> Eff effs a
toLoggedHTTP = handle $ \ListScenarios -> liftH $ do
  logMsg "Fetching a list of scenarios"
  lines <$> httpGET "/scenarios"
