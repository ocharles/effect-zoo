{-# LANGUAGE DataKinds, FlexibleContexts, GADTs, TypeOperators #-}

module EffectZoo.Scenario.FileSizes.Eff.File where

import           Control.Effect
import qualified EffectZoo.Scenario.FileSizes.Shared
                                               as Shared

data File :: Effect where
  TryFileSize :: FilePath -> File m (Maybe Int)

tryFileSize :: File :< effs => FilePath -> Eff effs (Maybe Int)
tryFileSize = send . TryFileSize

fileIO :: IOE :< effs => Eff (File ': effs) a -> Eff effs a
fileIO = handle $ \(TryFileSize path) ->
  liftH $ liftIO $ Shared.tryGetFileSize path
