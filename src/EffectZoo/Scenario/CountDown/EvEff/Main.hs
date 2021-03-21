module EffectZoo.Scenario.CountDown.EvEff.Main where

import           EffectZoo.Scenario.CountDown.EvEff.Program
import           Control.Ev.Eff
import           Control.Ev.Util

countDown :: Int -> (Int, Int)
countDown initial = runEff $ state initial
  $ program >>= \x -> perform get () >>= \y -> return (x, y)
