{-# LANGUAGE FlexibleContexts #-}

module EffectZoo.Scenario.CountDown.Reference where

import           Data.Functor.Identity

countDown :: Int -> (Int, Int)
countDown = program

program :: Int -> (Int, Int)
program n = if n <= 0 then (n, n) else program (n - 1)
