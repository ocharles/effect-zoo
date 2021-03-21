{-# LANGUAGE FlexibleContexts #-}

module EffectZoo.Scenario.FileSizes.Polysemy.Program where

import Polysemy
import EffectZoo.Scenario.FileSizes.Polysemy.File
import EffectZoo.Scenario.FileSizes.Polysemy.Logging

program :: (Member File effs, Member Logging effs) => [FilePath] -> Sem effs Int
program files = do
  sizes <- traverse calculateFileSize files
  return (sum sizes)

calculateFileSize
  :: (Member File effs, Member Logging effs) => FilePath -> Sem effs Int
calculateFileSize path = do
  logMsg ("Calculating the size of " ++ path)
  msize <- tryFileSize path
  case msize of
    Nothing   -> 0 <$ logMsg ("Could not calculate the size of " ++ path)
    Just size -> size <$ logMsg (path ++ " is " ++ show size ++ " bytes")
