module EffectZoo.Scenario.FileSizes.Eff.Main where

import           Control.Effect
import           Data.IORef
import           EffectZoo.Scenario.FileSizes.Eff.File
import           EffectZoo.Scenario.FileSizes.Eff.Logging
import           EffectZoo.Scenario.FileSizes.Eff.Program

calculateFileSizes :: [FilePath] -> IO (Int, [String])
calculateFileSizes files = do
  logs      <- newIORef []
  size      <- runIO (fileIO (logToIORef logs (program files)))
  finalLogs <- readIORef logs
  return (size, finalLogs)
