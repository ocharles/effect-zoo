module EffectZoo.Scenario.Reinterpretation.SimpleEffects.Main where

import           Data.Function                            ( (&) )
import           Control.Monad
import           Control.Effects.Reader
import           Control.Effects.State
import           EffectZoo.Scenario.Reinterpretation.SimpleEffects.HTTP
import           EffectZoo.Scenario.Reinterpretation.SimpleEffects.Logging
import           EffectZoo.Scenario.Reinterpretation.SimpleEffects.Zooit
                                               as Zooit
import           EffectZoo.Scenario.Reinterpretation.Shared

listScenarios :: Int -> IO ([String], [String])
listScenarios n =
  (   fmap concat (replicateM n (Zooit.listScenarios))
    >>= \x -> getState >>= \y -> return (x, y)
    )
    & toLoggedHTTP
    & mockResponses
    & accumulateLogMessages
    & implementReadEnv (return response)
    & implementStateViaStateT []
