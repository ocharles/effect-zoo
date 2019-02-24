{-# language FlexibleContexts #-}
module EffectZoo.Scenario.FileSizes.RIO.Program where

import RIO hiding ( HasLogFunc )
import EffectZoo.Scenario.FileSizes.RIO.Logging
import EffectZoo.Scenario.FileSizes.RIO.File


program :: ( HasLogFunc env, HasFileFunc env ) => [ FilePath ] -> RIO env Int
program files = do
  sizes <-
    traverse calculateFileSize files

  return ( sum sizes )


calculateFileSize
  :: ( HasLogFunc env, HasFileFunc env )
  => FilePath -> RIO env Int
calculateFileSize path = do
  logMsg ( "Calculating the size of " ++ path )

  msize <-
    tryFileSize path

  case msize of
    Nothing ->
      0 <$ logMsg ( "Could not calculate the size of " ++ path )

    Just size ->
      size <$ logMsg ( path ++ " is " ++ show size ++ " bytes" )
