module EffectZoo.Scenario.CountDown.MTL.LazyStateT where

import           Control.Monad.Trans.State.Lazy
import           EffectZoo.Scenario.CountDown.MTL.Program

countDown :: Int -> (Int, Int)
countDown initial = runState program initial
