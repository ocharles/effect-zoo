{-# language DeriveAnyClass, DeriveGeneric, FlexibleContexts, NoMonomorphismRestriction #-}
module EffectZoo.Scenario.FileSizes.SimpleEffects.File where

import Control.Effects
import Control.Monad.IO.Class
import qualified EffectZoo.Scenario.FileSizes.Shared as Shared
import GHC.Generics

data File m = File { _tryFileSize :: FilePath -> m ( Maybe Int ) }
  deriving ( Generic, Effect )

tryFileSize :: MonadEffect File m => FilePath -> m ( Maybe Int )
File tryFileSize = effect


fileIO :: MonadIO m => RuntimeImplemented File m a -> m a
fileIO =
  implement
    File
      { _tryFileSize = \path ->
          liftIO (Shared.tryGetFileSize path)
      }
