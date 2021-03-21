module EffectZoo.Scenario.BigStack.EvEff.Main where

import           Control.Ev.Eff
import           Control.Ev.Util
import           Control.Monad.Trans.Identity
import           Data.Function
import           EffectZoo.Scenario.BigStack.EvEff.Identity
import           EffectZoo.Scenario.BigStack.EvEff.Program
import qualified Data.Functor.Identity

bigStack0 :: Int -> Int
bigStack0 s =
  (program >> perform get ())
    & reader n
    & state s
    & runEff

bigStack1 :: Int -> Int
bigStack1 s =
  (program >> perform get ())
    & reader n
    & identity
    & state s
    & runEff

bigStack5 :: Int -> Int
bigStack5 s =
  (program >> perform get ())
    & reader n
    & identity
    & identity
    & identity
    & identity
    & identity
    & state s
    & runEff

bigStack10 :: Int -> Int
bigStack10 s =
  (program >> perform get ())
    & reader n
    & identity
    & identity
    & identity
    & identity
    & identity
    & identity
    & identity
    & identity
    & identity
    & identity
    & state s
    & runEff

bigStack20 :: Int -> Int
bigStack20 s =
  (program >> perform get ())
    & reader n
    & identity
    & identity
    & identity
    & identity
    & identity
    & identity
    & identity
    & identity
    & identity
    & identity
    & identity
    & identity
    & identity
    & identity
    & identity
    & identity
    & identity
    & identity
    & identity
    & identity
    & state s
    & runEff

n :: Int
n = 1000
