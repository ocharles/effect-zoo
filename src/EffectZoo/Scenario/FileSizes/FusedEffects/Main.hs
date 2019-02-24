module EffectZoo.Scenario.FileSizes.FusedEffects.Main where

import Data.IORef
import Control.Effect
import EffectZoo.Scenario.FileSizes.FusedEffects.Program
import EffectZoo.Scenario.FileSizes.FusedEffects.Logging
import EffectZoo.Scenario.FileSizes.FusedEffects.File


calculateFileSizes :: [ FilePath ] -> IO ( Int, [ String ] )
calculateFileSizes files = do
  logs <- newIORef []
  size <- runM ( runFileIOC2 ( runLogIOC2 logs ( program files ) ) )
  finalLogs <- readIORef logs
  return ( size, finalLogs )
