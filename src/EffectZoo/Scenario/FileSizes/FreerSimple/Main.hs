module EffectZoo.Scenario.FileSizes.FreerSimple.Main where

import           Control.Monad.Freer
import           Data.IORef
import           EffectZoo.Scenario.FileSizes.FreerSimple.File
import           EffectZoo.Scenario.FileSizes.FreerSimple.Logging
import           EffectZoo.Scenario.FileSizes.FreerSimple.Program

calculateFileSizes :: [FilePath] -> IO (Int, [String])
calculateFileSizes files = do
  logs      <- newIORef []
  size      <- runM (fileIO (logToIORef logs (program files)))
  finalLogs <- readIORef logs
  return (size, finalLogs)
