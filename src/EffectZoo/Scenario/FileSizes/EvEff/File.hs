{-# LANGUAGE FlexibleContexts, RankNTypes #-}

module EffectZoo.Scenario.FileSizes.EvEff.File where

import           Control.Ev.Eff
import           Control.Ev.Monad
import qualified EffectZoo.Scenario.FileSizes.Shared
                                               as Shared
newtype File e ans = File
  { tryFileSizeOp :: Op FilePath (Maybe Int) e ans
  }

tryFileSize :: (File :? e) => FilePath -> Eff e (Maybe Int)
tryFileSize = perform tryFileSizeOp

fileIO :: IOEff :? e => Eff (File :* e) a -> Eff e a
fileIO = handler File
  { tryFileSizeOp = function (performIO . Shared.tryGetFileSize)
  }
