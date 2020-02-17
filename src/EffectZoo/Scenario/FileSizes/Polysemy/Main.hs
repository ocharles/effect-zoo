module EffectZoo.Scenario.FileSizes.Polysemy.Main where

import Polysemy
import Data.IORef
import EffectZoo.Scenario.FileSizes.Polysemy.File
import EffectZoo.Scenario.FileSizes.Polysemy.Logging
import EffectZoo.Scenario.FileSizes.Polysemy.Program

calculateFileSizes :: [FilePath] -> IO (Int, [String])
calculateFileSizes files = do
  logs      <- newIORef []
  size      <- runM (fileIO (logToIORef logs (program files)))
  finalLogs <- readIORef logs
  return (size, finalLogs)
