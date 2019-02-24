{-# LANGUAGE FlexibleContexts #-}

module EffectZoo.Scenario.FileSizes.FusedEffects.Program where

import           Control.Effect
import           EffectZoo.Scenario.FileSizes.FusedEffects.File
import           EffectZoo.Scenario.FileSizes.FusedEffects.Logging

program
  :: (Member File sig, Member Logging sig, Carrier sig m, Monad m)
  => [FilePath]
  -> m Int
program files = do
  sizes <- traverse calculateFileSize files
  return (sum sizes)

calculateFileSize
  :: (Member File sig, Member Logging sig, Carrier sig m, Monad m)
  => FilePath
  -> m Int
calculateFileSize path = do
  logMsg ("Calculating the size of " ++ path)
  msize <- tryFileSize path
  case msize of
    Nothing   -> 0 <$ logMsg ("Could not calculate the size of " ++ path)
    Just size -> size <$ logMsg (path ++ " is " ++ show size ++ " bytes")
