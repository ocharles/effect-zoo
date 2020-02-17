module EffectZoo.Scenario.BigStack.Eff.Main where

import "eff" Control.Effect
import           Data.Function
import           EffectZoo.Scenario.BigStack.Eff.Identity
import           EffectZoo.Scenario.BigStack.Eff.Program

bigStack0 :: Int -> Int
bigStack0 s = program & runReader n & execState s & run

bigStack1 :: Int -> Int
bigStack1 s = program & runReader n & runIdentity & execState s & run

bigStack5 :: Int -> Int
bigStack5 s =
  program
    & runReader n
    & runIdentity
    & runIdentity
    & runIdentity
    & runIdentity
    & runIdentity
    & execState s
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
    & execState s
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
    & execState s
    & run

n :: Int
n = 1000
