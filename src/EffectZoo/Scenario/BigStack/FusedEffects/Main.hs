{-# LANGUAGE FlexibleContexts #-}

module EffectZoo.Scenario.BigStack.FusedEffects.Main where

import Control.Effect
import Control.Effect
import Control.Effect.Fresh
import Control.Effect.Reader
import Control.Effect.Reader
import Control.Effect.State
import Control.Effect.State
import Control.Monad
import Data.Function
import Data.Functor.Identity
import EffectZoo.Scenario.BigStack.FusedEffects.Program

bigStack0 :: Int -> Int
bigStack0 s = program & runReader n & execState s & run

bigStack1 :: Int -> Int
bigStack1 s = program & runReader n & runFresh & execState s & run

bigStack5 :: Int -> Int
bigStack5 s =
  program & runReader n & runFresh & runFresh & runFresh & runFresh & runFresh &
  execState s &
  run

bigStack10 :: Int -> Int
bigStack10 s =
  program & runReader n & runFresh & runFresh & runFresh & runFresh & runFresh &
  runFresh &
  runFresh &
  runFresh &
  runFresh &
  runFresh &
  execState s &
  run

n :: Int
n = 1000
