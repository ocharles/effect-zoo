module EffectZoo.Scenario.State.MTL.StrictStateT where

import Control.Monad.Trans.State.Strict
import EffectZoo.Scenario.State.MTL.Program

countDown :: Int -> (Int, Int)
countDown initial = runState program initial
