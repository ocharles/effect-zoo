{-# LANGUAGE DataKinds, FlexibleContexts, GADTs, TypeOperators #-}

module EffectZoo.Scenario.FileSizes.FreerSimple.File where

import           Control.Monad.Freer
import qualified EffectZoo.Scenario.FileSizes.Shared
                                               as Shared

data File a where
  TryFileSize :: FilePath -> File (Maybe Int)

tryFileSize :: Member File effs => FilePath -> Eff effs (Maybe Int)
tryFileSize = send . TryFileSize

fileIO :: LastMember IO effs => Eff (File ': effs) a -> Eff effs a
fileIO = interpret (\(TryFileSize path) -> sendM $ Shared.tryGetFileSize path)
