module EffectZoo.Scenario.FileSizes.EvEff.Main where

import           Control.Ev.Eff
import           Control.Ev.Monad
import           Data.IORef
import           EffectZoo.Scenario.FileSizes.EvEff.File
import           EffectZoo.Scenario.FileSizes.EvEff.Logging
import           EffectZoo.Scenario.FileSizes.EvEff.Program

calculateFileSizes :: [FilePath] -> IO (Int, [String])
calculateFileSizes files = do
  logs      <- newIORef []
  size      <- runIOEff (fileIO (logToIORef logs (program files)))
  finalLogs <- readIORef logs
  return (size, finalLogs)
