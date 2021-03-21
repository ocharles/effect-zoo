module EffectZoo.Scenario.Reinterpretation.Polysemy.Main where

import Control.Monad
import Polysemy
import Polysemy.Reader
import Polysemy.Writer
import Data.Function
import EffectZoo.Scenario.Reinterpretation.Polysemy.HTTP
import EffectZoo.Scenario.Reinterpretation.Polysemy.Logging
import EffectZoo.Scenario.Reinterpretation.Polysemy.Zooit
                                               as Zooit
import EffectZoo.Scenario.Reinterpretation.Shared

listScenarios :: Int -> ([String], [String])
listScenarios n =
  fmap concat (replicateM n Zooit.listScenarios)
    & toLoggedHTTP
    & runReader response
    . mockResponses
    & runWriter
    . accumulateLogMessages
    & run
