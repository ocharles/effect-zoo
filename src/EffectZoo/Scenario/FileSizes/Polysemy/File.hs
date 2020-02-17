{-# LANGUAGE DataKinds, FlexibleContexts, GADTs, TypeOperators #-}

module EffectZoo.Scenario.FileSizes.Polysemy.File where

import Polysemy
import qualified EffectZoo.Scenario.FileSizes.Shared
                                               as Shared

data File (m :: * -> *) a where
  TryFileSize :: FilePath -> File m (Maybe Int)
makeSem ''File

fileIO :: Member (Embed IO) effs => Sem (File ': effs) a -> Sem effs a
fileIO = interpret (\(TryFileSize path) -> embed $ Shared.tryGetFileSize path)
