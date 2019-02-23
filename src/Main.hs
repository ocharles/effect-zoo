module Main where

import Criterion.Main
import EffectZoo.Scenario.State


main :: IO ()
main =
  defaultMain [ benchmarks ]
