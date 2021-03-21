module EffectZoo.Scenario.Reinterpretation.FreerSimple.Main where

import           Control.Monad
import           Control.Monad.Freer
import           Control.Monad.Freer.Reader
import           Control.Monad.Freer.Writer
import           Data.Function
import           EffectZoo.Scenario.Reinterpretation.FreerSimple.HTTP
import           EffectZoo.Scenario.Reinterpretation.FreerSimple.Logging
import           EffectZoo.Scenario.Reinterpretation.FreerSimple.Zooit
                                               as Zooit
import           EffectZoo.Scenario.Reinterpretation.Shared

listScenarios :: Int -> ([String], [String])
listScenarios n =
  fmap concat (replicateM n Zooit.listScenarios)
    & toLoggedHTTP
    & runReader response
    . mockResponses
    & runWriter
    . accumulateLogMessages
    & run
