module EffectZoo.Scenario.FileSizes.FreerSimple.Main where

import Data.IORef
import Control.Monad.Freer
import EffectZoo.Scenario.FileSizes.FreerSimple.Program
import EffectZoo.Scenario.FileSizes.FreerSimple.Logging
import EffectZoo.Scenario.FileSizes.FreerSimple.File


calculateFileSizes :: [ FilePath ] -> IO ( Int, [ String ] )
calculateFileSizes files = do
  logs <- newIORef []
  size <- runM ( fileIO ( logToIORef logs ( program files ) ) )
  finalLogs <- readIORef logs
  return ( size, finalLogs )
