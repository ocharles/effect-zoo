module EffectZoo.Scenario.CountDown.MTL.StrictStateT where

import           Control.Monad.Trans.State.Strict
import           EffectZoo.Scenario.CountDown.MTL.Program

countDown :: Int -> (Int, Int)
countDown initial = runState program initial
