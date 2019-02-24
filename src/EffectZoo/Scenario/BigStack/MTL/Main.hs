module EffectZoo.Scenario.BigStack.MTL.Main where

import Control.Monad.Trans.Reader
import Control.Monad.Trans.State.Strict
import Control.Monad.Trans.Identity
import Data.Function
import EffectZoo.Scenario.BigStack.MTL.Program


bigStack0 :: Int -> Int
bigStack0 s =
  program
    & ( `runReaderT` n )
    & ( `execState` s )


bigStack1 :: Int -> Int
bigStack1 s =
  program
    & ( `runReaderT` n )
    & runIdentityT
    & ( `execState` s )


bigStack5 :: Int -> Int
bigStack5 s =
  program
    & ( `runReaderT` n )
    & runIdentityT
    & runIdentityT
    & runIdentityT
    & runIdentityT
    & runIdentityT
    & ( `execState` s )


bigStack10 :: Int -> Int
bigStack10 s =
  program
    & ( `runReaderT` n )
    & runIdentityT
    & runIdentityT
    & runIdentityT
    & runIdentityT
    & runIdentityT
    & runIdentityT
    & runIdentityT
    & runIdentityT
    & runIdentityT
    & runIdentityT
    & ( `execState` s )

    
n :: Int
n = 1000
