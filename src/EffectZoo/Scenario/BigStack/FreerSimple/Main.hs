module EffectZoo.Scenario.BigStack.FreerSimple.Main where

import           Control.Monad.Freer
import           Control.Monad.Freer.Reader
import           Control.Monad.Freer.State
import           Data.Function
import           EffectZoo.Scenario.BigStack.FreerSimple.Identity
import           EffectZoo.Scenario.BigStack.FreerSimple.Program

bigStack0 :: Int -> Int
bigStack0 s = program & runReader n & execState 0 & run

bigStack1 :: Int -> Int
bigStack1 s = program & runReader n & runIdentity & execState 0 & run

bigStack5 :: Int -> Int
bigStack5 s =
  program
    & runReader n
    & runIdentity
    & runIdentity
    & runIdentity
    & runIdentity
    & runIdentity
    & execState 0
    & run

bigStack10 :: Int -> Int
bigStack10 s =
  program
    & runReader n
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
    & execState 0
    & run

bigStack20 :: Int -> Int
bigStack20 s =
  program
    & runReader n
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
    & execState 0
    & run

n :: Int
n = 1000
