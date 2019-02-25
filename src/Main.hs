module Main where

import           Criterion.Main
import           EffectZoo.Scenario.BigStack
import           EffectZoo.Scenario.FileSizes
import           EffectZoo.Scenario.Reinterpretation
import           EffectZoo.Scenario.CountDown
import           EffectZoo.Scenario.NoInline
import           EffectZoo.Scenario.Inline

main :: IO ()
main = defaultMain
  [ EffectZoo.Scenario.FileSizes.benchmarks
  , EffectZoo.Scenario.CountDown.benchmarks
  , EffectZoo.Scenario.BigStack.benchmarks
  , EffectZoo.Scenario.NoInline.benchmarks
  , EffectZoo.Scenario.Inline.benchmarks
  , EffectZoo.Scenario.Reinterpretation.benchmarks
  ]
