{-# language FlexibleContexts #-}
module EffectZoo.Scenario.FileSizes.Reference where

import Data.IORef
import qualified EffectZoo.Scenario.FileSizes.Shared as Shared

calculateFileSizes :: [ FilePath ] -> IO ( Int, [ String ] )
calculateFileSizes files = do
  logs <- newIORef []
  size <- program logs files
  finalLogs <- readIORef logs
  return ( size, finalLogs )


program :: IORef [ String ] -> [ FilePath ] -> IO Int
program logs files = do
  sizes <-
    traverse ( calculateFileSize logs ) files

  return ( sum sizes )


calculateFileSize
  :: IORef [ String ] -> FilePath -> IO Int
calculateFileSize logs path = do
  Shared.logToIORef logs ( "Calculating the size of " ++ path )

  msize <-
    Shared.tryGetFileSize path

  case msize of
    Nothing ->
      0 <$ Shared.logToIORef logs ( "Could not calculate the size of " ++ path )

    Just size ->
      size <$ Shared.logToIORef logs ( path ++ " is " ++ show size ++ " bytes" )
