module EffectZoo.Scenario.FileSizes.SimpleEffects.Main where

import Data.IORef
import EffectZoo.Scenario.FileSizes.SimpleEffects.Program
import EffectZoo.Scenario.FileSizes.SimpleEffects.Logging
import EffectZoo.Scenario.FileSizes.SimpleEffects.File


calculateFileSizes :: [ FilePath ] -> IO ( Int, [ String ] )
calculateFileSizes files = do
  logs <- newIORef []
  size <- fileIO ( logToIORef logs ( program files ) )
  finalLogs <- readIORef logs
  return ( size, finalLogs )
