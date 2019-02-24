module EffectZoo.Scenario.State.MTL.LazyStateT where

import Control.Monad.Trans.State.Lazy
import EffectZoo.Scenario.State.MTL.Program

countDown :: Int -> (Int, Int)
countDown initial = runState program initial
