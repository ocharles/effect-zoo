{-# language FlexibleContexts #-}
module EffectZoo.Scenario.FileSizes.FreerSimple.Program where

import Control.Monad.Freer
import EffectZoo.Scenario.FileSizes.FreerSimple.Logging
import EffectZoo.Scenario.FileSizes.FreerSimple.File


program :: ( Member File effs, Member Logging effs ) => [ FilePath ] -> Eff effs Int
program files = do
  sizes <-
    traverse calculateFileSize files

  return ( sum sizes )


calculateFileSize
  :: ( Member File effs, Member Logging effs )
  => FilePath -> Eff effs Int
calculateFileSize path = do
  logMsg ( "Calculating the size of " ++ path )

  msize <-
    tryFileSize path

  case msize of
    Nothing ->
      0 <$ logMsg ( "Could not calculate the size of " ++ path )

    Just size ->
      size <$ logMsg ( path ++ " is " ++ show size ++ " bytes" )
