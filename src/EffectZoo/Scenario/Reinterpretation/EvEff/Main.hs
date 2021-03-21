module EffectZoo.Scenario.Reinterpretation.EvEff.Main where

import           Control.Monad
import           Control.Ev.Eff
import           Control.Ev.Util
import           Data.Function
import           EffectZoo.Scenario.Reinterpretation.EvEff.HTTP
import           EffectZoo.Scenario.Reinterpretation.EvEff.Logging
import           EffectZoo.Scenario.Reinterpretation.EvEff.Zooit
                                               as Zooit
import           EffectZoo.Scenario.Reinterpretation.Shared

listScenarios :: Int -> ([String], [String])
listScenarios n =
  fmap concat (replicateM n Zooit.listScenarios)
    & toLoggedHTTP
    & reader response
    . mockResponses
    & writer
    . accumulateLogMessages
    & runEff
