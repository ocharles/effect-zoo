{-# LANGUAGE FlexibleContexts #-}

module EffectZoo.Scenario.FileSizes.EvEff.Program where

import           Control.Ev.Eff
import           EffectZoo.Scenario.FileSizes.EvEff.File
import           EffectZoo.Scenario.FileSizes.EvEff.Logging

program :: (File :? e, Logging :? e) => [FilePath] -> Eff e Int
program files = do
  sizes <- traverse calculateFileSize files
  return (sum sizes)

calculateFileSize
  :: (File :? e, Logging :? e) => FilePath -> Eff e Int
calculateFileSize path = do
  logMsg ("Calculating the size of " ++ path)
  msize <- tryFileSize path
  case msize of
    Nothing   -> 0 <$ logMsg ("Could not calculate the size of " ++ path)
    Just size -> size <$ logMsg (path ++ " is " ++ show size ++ " bytes")
