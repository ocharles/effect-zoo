module EffectZoo.Scenario.NoInline.FreerSimple.Main where

import           Control.Monad.Freer
import           EffectZoo.Scenario.NoInline.FreerSimple.Noop
import           EffectZoo.Scenario.NoInline.FreerSimple.Program

noops :: Int -> IO Int
noops = runM . runNoop . program
