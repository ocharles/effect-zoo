{-# language FlexibleContexts #-}
module EffectZoo.Scenario.NoInline.SimpleEffects.Program where

import           Control.Effects
import           Control.Monad
import           EffectZoo.Scenario.NoInline.SimpleEffects.Increment

program :: MonadEffect Increment m => Int -> m ()
program n = replicateM_ n increment
{-# NOINLINE program #-}
