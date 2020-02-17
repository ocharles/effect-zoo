{-# LANGUAGE FlexibleContexts #-}

module EffectZoo.Scenario.FileSizes.Eff.Program where

import           Control.Effect
import           EffectZoo.Scenario.FileSizes.Eff.File
import           EffectZoo.Scenario.FileSizes.Eff.Logging

program :: (File :< effs, Logging :< effs) => [FilePath] -> Eff effs Int
program files = do
  sizes <- traverse calculateFileSize files
  return (sum sizes)

calculateFileSize
  :: (File :< effs, Logging :< effs) => FilePath -> Eff effs Int
calculateFileSize path = do
  logMsg ("Calculating the size of " ++ path)
  msize <- tryFileSize path
  case msize of
    Nothing   -> 0 <$ logMsg ("Could not calculate the size of " ++ path)
    Just size -> size <$ logMsg (path ++ " is " ++ show size ++ " bytes")
