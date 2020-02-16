{-# LANGUAGE FlexibleContexts #-}

module EffectZoo.Scenario.FileSizes.FusedEffects.Program where

import "fused-effects" Control.Algebra
import           EffectZoo.Scenario.FileSizes.FusedEffects.File
import           EffectZoo.Scenario.FileSizes.FusedEffects.Logging

program
  :: (Has File sig m, Has Logging sig m)
  => [FilePath]
  -> m Int
program files = do
  sizes <- traverse calculateFileSize files
  return (sum sizes)

calculateFileSize
  :: (Has File sig m, Has Logging sig m)
  => FilePath
  -> m Int
calculateFileSize path = do
  logMsg ("Calculating the size of " ++ path)
  msize <- tryFileSize path
  case msize of
    Nothing   -> 0 <$ logMsg ("Could not calculate the size of " ++ path)
    Just size -> size <$ logMsg (path ++ " is " ++ show size ++ " bytes")
