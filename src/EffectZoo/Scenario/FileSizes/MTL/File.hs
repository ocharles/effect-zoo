{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module EffectZoo.Scenario.FileSizes.MTL.File where

import Control.Monad.IO.Class
import qualified EffectZoo.Scenario.FileSizes.Shared as Shared

class Monad m =>
      MonadFile m
  where
  tryFileSize :: FilePath -> m (Maybe Int)

newtype FileT m a = FileT
  { runFileT :: m a
  } deriving (Functor, Applicative, Monad, MonadIO)

instance MonadIO m => MonadFile (FileT m) where
  tryFileSize path = liftIO (Shared.tryGetFileSize path)
