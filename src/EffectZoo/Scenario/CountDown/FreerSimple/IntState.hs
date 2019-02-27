{-# language DataKinds, FlexibleContexts, GADTs, TypeOperators #-}

module EffectZoo.Scenario.CountDown.FreerSimple.IntState where

import           Control.Monad.Freer
import           Control.Monad.Freer.Internal

data IntState a where
  Get :: IntState Int
  Put :: Int -> IntState ()

get :: Member IntState effs => Eff effs Int
get = send Get

put :: Member IntState effs => Int -> Eff effs ()
put = send . Put

runState :: Int -> Eff (IntState ': effs) a -> Eff effs (a, Int)
runState s e = handleRelayS
  s
  (\s x -> pure (x, s))
  (\s e k -> case e of
    Get    -> k s s
    Put s' -> k s' ()
  )
  e
