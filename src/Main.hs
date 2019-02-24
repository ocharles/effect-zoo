module Main where

import Criterion.Main
import EffectZoo.Scenario.BigStack
import EffectZoo.Scenario.State
import EffectZoo.Scenario.FileSizes


main :: IO ()
main =
  defaultMain [ EffectZoo.Scenario.FileSizes.benchmarks
              , EffectZoo.Scenario.State.benchmarks
              , EffectZoo.Scenario.BigStack.benchmarks
              ]
