module EffectZoo.Scenario.BigStack.SimpleEffects.Main where

import           Control.Effects
import           Control.Effects.Reader
import           Control.Effects.State
import           Control.Monad.Trans.Identity
import           Data.Function
import           EffectZoo.Scenario.BigStack.SimpleEffects.Identity
import           EffectZoo.Scenario.BigStack.SimpleEffects.Program
import qualified Data.Functor.Identity

bigStack0 :: Int -> Int
bigStack0 s =
  (program >> getState)
    & implementReadEnv (return n)
    & implementStateViaStateT s
    & Data.Functor.Identity.runIdentity

bigStack1 :: Int -> Int
bigStack1 s =
  (program >> getState)
    & implementReadEnv (return n)
    & runIdentity
    & implementStateViaStateT s
    & Data.Functor.Identity.runIdentity

bigStack5 :: Int -> Int
bigStack5 s =
  (program >> getState)
    & implementReadEnv (return n)
    & runIdentity
    & runIdentity
    & runIdentity
    & runIdentity
    & runIdentity
    & implementStateViaStateT s
    & Data.Functor.Identity.runIdentity

bigStack10 :: Int -> Int
bigStack10 s =
  (program >> getState)
    & implementReadEnv (return n)
    & runIdentity
    & runIdentity
    & runIdentity
    & runIdentity
    & runIdentity
    & runIdentity
    & runIdentity
    & runIdentity
    & runIdentity
    & runIdentity
    & implementStateViaStateT s
    & Data.Functor.Identity.runIdentity

bigStack20 :: Int -> Int
bigStack20 s =
  (program >> getState)
    & implementReadEnv (return n)
    & runIdentity
    & runIdentity
    & runIdentity
    & runIdentity
    & runIdentity
    & runIdentity
    & runIdentity
    & runIdentity
    & runIdentity
    & runIdentity
    & runIdentity
    & runIdentity
    & runIdentity
    & runIdentity
    & runIdentity
    & runIdentity
    & runIdentity
    & runIdentity
    & runIdentity
    & runIdentity
    & implementStateViaStateT s
    & Data.Functor.Identity.runIdentity

n :: Int
n = 1000
