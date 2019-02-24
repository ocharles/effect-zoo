module EffectZoo.Scenario.FileSizes.MTL.Program where

import Control.Effects
import EffectZoo.Scenario.FileSizes.MTL.Logging
import EffectZoo.Scenario.FileSizes.MTL.File


program :: ( MonadLog m, MonadFile m ) => [ FilePath ] -> m Int
program files = do
  sizes <-
    traverse calculateFileSize files

  return ( sum sizes )


calculateFileSize
  :: ( MonadLog m, MonadFile m )
  => FilePath -> m Int
calculateFileSize path = do
  logMsg ( "Calculating the size of " ++ path )

  msize <-
    tryFileSize path

  case msize of
    Nothing ->
      0 <$ logMsg ( "Could not calculate the size of " ++ path )

    Just size ->
      size <$ logMsg ( path ++ " is " ++ show size ++ " bytes" )
