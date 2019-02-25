{-# language DataKinds, FlexibleContexts, GADTs, TypeOperators #-}

module EffectZoo.Scenario.Inline.FreerSimple (noops) where

import           Control.Monad
import           Control.Monad.Freer
import           Control.Monad.Freer.Internal

data Noop a where
  Noop :: Noop ()

noop :: Member Noop effs => Eff effs ()
noop = send Noop
{-# INLINE noop #-}

runNoop :: Eff (Noop ': effs) a -> Eff effs Int
runNoop e =
  fmap snd (handleRelayS 0 (\s x -> pure (x, s)) (\s Noop k -> k (s + 1) ()) e)
{-# INLINE runNoop #-}

noops :: Int -> IO Int
noops n = runM ( runNoop ( replicateM_ n noop ) )
