module EffectZoo.Scenario.FileSizes.MTL.Main where

import           Control.Monad.Trans.Class
import           Data.IORef
import           EffectZoo.Scenario.FileSizes.MTL.File
import           EffectZoo.Scenario.FileSizes.MTL.Logging
import           EffectZoo.Scenario.FileSizes.MTL.Program

instance MonadFile m => MonadFile (LogToIORef m) where
  tryFileSize = lift . tryFileSize

calculateFileSizes :: [FilePath] -> IO (Int, [String])
calculateFileSizes files = do
  logs      <- newIORef []
  size      <- runFileT (runLogToIORefT (program files) logs)
  finalLogs <- readIORef logs
  return (size, finalLogs)
