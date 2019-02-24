module EffectZoo.Scenario.FileSizes.FusedEffects.Main where

import Control.Effect
import Data.IORef
import EffectZoo.Scenario.FileSizes.FusedEffects.File
import EffectZoo.Scenario.FileSizes.FusedEffects.Logging
import EffectZoo.Scenario.FileSizes.FusedEffects.Program

calculateFileSizes :: [FilePath] -> IO (Int, [String])
calculateFileSizes files = do
  logs <- newIORef []
  size <- runM (runFileIOC2 (runLogIOC2 logs (program files)))
  finalLogs <- readIORef logs
  return (size, finalLogs)
