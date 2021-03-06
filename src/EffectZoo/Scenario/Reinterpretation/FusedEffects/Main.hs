module EffectZoo.Scenario.Reinterpretation.FusedEffects.Main where

import           Control.Monad
import           Control.Effect
import           Control.Effect.Reader
import           Control.Effect.Writer
import           Data.Function
import           EffectZoo.Scenario.Reinterpretation.FusedEffects.HTTP
import           EffectZoo.Scenario.Reinterpretation.FusedEffects.Logging
import           EffectZoo.Scenario.Reinterpretation.FusedEffects.Zooit
                                               as Zooit
import           EffectZoo.Scenario.Reinterpretation.Shared

listScenarios :: Int -> IO ([String], [String])
listScenarios n =
  fmap concat (replicateM n Zooit.listScenarios)
    & toLoggedHTTP
    & mockResponses
    & runReader response
    & accumulateLogMessages
    & runWriter
    & runM
