module EffectZoo.Scenario.FileSizes.Shared where

import           Control.Exception
import           Data.IORef
import           System.Posix

tryGetFileSize :: FilePath -> IO (Maybe Int)
tryGetFileSize path = do
  estat <- try (getFileStatus path)
  case estat of
    Left  SomeException{} -> return Nothing
    Right stat            -> return (Just (fromIntegral (fileSize stat)))

{-# INLINE tryGetFileSize #-}
logToIORef :: IORef [String] -> String -> IO ()
logToIORef r msg = modifyIORef r (msg :)

{-# INLINE logToIORef #-}
