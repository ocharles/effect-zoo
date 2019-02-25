module Main where

import           Criterion.Main
import           EffectZoo.Scenario.BigStack
import           EffectZoo.Scenario.FileSizes
import           EffectZoo.Scenario.State
import           EffectZoo.Scenario.NoInline

main :: IO ()
main = defaultMain
  [ EffectZoo.Scenario.FileSizes.benchmarks
  , EffectZoo.Scenario.State.benchmarks
  , EffectZoo.Scenario.BigStack.benchmarks
  , EffectZoo.Scenario.NoInline.benchmarks
  ]
