{-# language FlexibleContexts #-}

module EffectZoo.Scenario.NoInline.FreerSimple.Program where

import           Control.Monad
import           Control.Monad.Freer
import           EffectZoo.Scenario.NoInline.FreerSimple.Noop

program :: Member Noop effs => Int -> Eff effs ()
program n = replicateM_ n noop
{-# NOINLINE program #-}
