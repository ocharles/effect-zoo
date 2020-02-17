{-# OPTIONS_GHC -dsuppress-type-signatures #-}
module EffectZoo.Scenario.CountDown.FusedEffects.Main where

import "fused-effects" Control.Algebra
import "fused-effects" Control.Carrier.State.Strict
import           EffectZoo.Scenario.CountDown.FusedEffects.Program

countDown :: Int -> (Int, Int)
countDown initial = run (runState initial program)
