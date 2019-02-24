{-# language GeneralizedNewtypeDeriving #-}

module EffectZoo.Scenario.FileSizes.MTL.Logging where

import Data.IORef
import Control.Monad.IO.Class
import Control.Monad.Trans.Class
import Control.Monad.Trans.Reader
import qualified EffectZoo.Scenario.FileSizes.Shared as Shared

class Monad m => MonadLog m where
  logMsg :: String -> m ()

newtype LogToIORef m a = LogToIORef (ReaderT (IORef [ String ]) m a)
  deriving (Functor, Applicative, Monad, MonadIO )

instance MonadTrans LogToIORef where
  lift =
    LogToIORef . lift

instance MonadIO m => MonadLog ( LogToIORef m ) where
  logMsg msg =
    LogToIORef $ do
      ref <- ask
      liftIO ( Shared.logToIORef ref msg )


runLogToIORefT :: LogToIORef m a -> IORef [String] -> m a
runLogToIORefT (LogToIORef (ReaderT m)) ref =
  m ref
