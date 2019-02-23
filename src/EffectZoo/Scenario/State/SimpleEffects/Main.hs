module EffectZoo.Scenario.State.SimpleEffects.Main where

import Control.Effects
import Control.Effects.State
import Data.Functor.Identity
import EffectZoo.Scenario.State.SimpleEffects.Program


countDown :: Int -> ( Int, Int )
countDown initial =
  runIdentity ( implementStateViaStateT initial program' )

  where

    program' = do
      n <- program
      s <- getState
      return ( n, s )
