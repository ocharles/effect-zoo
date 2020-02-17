{-# OPTIONS_GHC -dsuppress-type-signatures #-}
module EffectZoo.Scenario.CountDown.Eff.Main where

import "eff" Control.Effect
import           EffectZoo.Scenario.CountDown.Eff.Program

countDown :: Int -> (Int, Int)
countDown initial = run (runState initial program)
