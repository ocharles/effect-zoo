{-# language DataKinds, FlexibleContexts, GADTs, TypeOperators #-}
module EffectZoo.Scenario.Reinterpretation.Polysemy.Zooit where

import Polysemy
import EffectZoo.Scenario.Reinterpretation.Polysemy.Logging
import EffectZoo.Scenario.Reinterpretation.Polysemy.HTTP

data Zooit (m :: * -> *) a where
  ListScenarios :: Zooit m [String]
makeSem ''Zooit

toLoggedHTTP :: Sem (Zooit ': effs) a -> Sem (HTTP ': Logging ': effs) a
toLoggedHTTP = reinterpret2 $ \ListScenarios -> do
  logMsg "Fetching a list of scenarios"
  lines <$> httpGET "/scenarios"
