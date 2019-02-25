{-# language FlexibleContexts #-}
module EffectZoo.Scenario.NoInline.FusedEffects.Program where

import           Control.Effect
import           Control.Monad
import           EffectZoo.Scenario.NoInline.FusedEffects.Increment

program :: (Member Increment sig, Carrier sig m, Monad m) => Int -> m ()
program n = replicateM_ n increment
{-# NOINLINE program #-}
