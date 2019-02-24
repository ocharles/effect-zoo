module EffectZoo.Scenario.BigStack.SimpleEffects.Main where

import Control.Effects
import Control.Effects.Reader
import Control.Effects.State
import Control.Monad.Trans.Identity
import Data.Function
import Data.Functor.Identity
import EffectZoo.Scenario.BigStack.SimpleEffects.Program

bigStack0 :: Int -> Int
bigStack0 s =
  (program >> getState) & implementReadEnv (return n) &
  implementStateViaStateT s &
  runIdentity

bigStack1 :: Int -> Int
bigStack1 s =
  (program >> getState) & implementReadEnv (return n) & runIdentityT &
  implementStateViaStateT s &
  runIdentity

bigStack5 :: Int -> Int
bigStack5 s =
  (program >> getState) & implementReadEnv (return n) & runIdentityT &
  runIdentityT &
  runIdentityT &
  runIdentityT &
  runIdentityT &
  implementStateViaStateT s &
  runIdentity

bigStack10 :: Int -> Int
bigStack10 s =
  (program >> getState) & implementReadEnv (return n) & runIdentityT &
  runIdentityT &
  runIdentityT &
  runIdentityT &
  runIdentityT &
  runIdentityT &
  runIdentityT &
  runIdentityT &
  runIdentityT &
  runIdentityT &
  implementStateViaStateT s &
  runIdentity

n :: Int
n = 1000
