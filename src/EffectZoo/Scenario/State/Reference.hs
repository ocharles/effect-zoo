{-# LANGUAGE FlexibleContexts #-}

module EffectZoo.Scenario.State.Reference where

import Data.Functor.Identity

countDown :: Int -> (Int, Int)
countDown = runIdentity . program

program :: Int -> Identity (Int, Int)
program n =
  if n <= 0
    then pure (n, n)
    else program (n - 1)
