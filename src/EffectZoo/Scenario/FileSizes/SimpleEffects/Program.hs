{-# LANGUAGE DataKinds #-}

module EffectZoo.Scenario.FileSizes.SimpleEffects.Program where

import           Control.Effects
import           EffectZoo.Scenario.FileSizes.SimpleEffects.File
import           EffectZoo.Scenario.FileSizes.SimpleEffects.Logging

program :: MonadEffects '[File, Logging] m => [FilePath] -> m Int
program files = do
  sizes <- traverse calculateFileSize files
  return (sum sizes)

calculateFileSize :: MonadEffects '[File, Logging] m => FilePath -> m Int
calculateFileSize path = do
  logMsg ("Calculating the size of " ++ path)
  msize <- tryFileSize path
  case msize of
    Nothing   -> 0 <$ logMsg ("Could not calculate the size of " ++ path)
    Just size -> size <$ logMsg (path ++ " is " ++ show size ++ " bytes")
