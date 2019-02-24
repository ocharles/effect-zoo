module EffectZoo.Scenario.FileSizes.RIO.Main where

import           EffectZoo.Scenario.FileSizes.RIO.File
import           EffectZoo.Scenario.FileSizes.RIO.Logging
import           EffectZoo.Scenario.FileSizes.RIO.Program
import           RIO                               hiding ( HasLogFunc(..)
                                                          , LogFunc
                                                          )

data Env = Env
  { logFunc :: LogFunc
  , fileFunc :: FileFunc
  }

instance HasLogFunc Env where
  logFuncL f e = f (logFunc e) <&> \logFunc' -> e {logFunc = logFunc'}

instance HasFileFunc Env where
  fileFuncL f e = f (fileFunc e) <&> \fileFunc' -> e {fileFunc = fileFunc'}

calculateFileSizes :: [FilePath] -> IO (Int, [String])
calculateFileSizes files = do
  logs <- newIORef []
  let env = Env {logFunc = logToIORef logs, fileFunc = ioFileFunc}
  size      <- runRIO env (program files)
  finalLogs <- readIORef logs
  return (size, finalLogs)
