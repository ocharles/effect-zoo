{-# OPTIONS_GHC -dsuppress-uniques #-}

module EffectZoo.Scenario.Reinterpretation.Eff.Main where

import           Control.Monad
import Control.Effect
import           Data.Function
import           EffectZoo.Scenario.Reinterpretation.Eff.HTTP
import           EffectZoo.Scenario.Reinterpretation.Eff.Logging
import           EffectZoo.Scenario.Reinterpretation.Eff.Zooit
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
