{-# LANGUAGE DataKinds, FlexibleContexts, GADTs, TypeOperators,
  KindSignatures, FlexibleInstances, MultiParamTypeClasses,
  UndecidableInstances, DeriveFunctor, GeneralizedNewtypeDeriving #-}

module EffectZoo.Scenario.FileSizes.FusedEffects.File where

import GHC.Generics (Generic1)
import "fused-effects" Control.Algebra
import "fused-effects" Control.Effect.Sum
import           Control.Monad.IO.Class
import           Control.Monad.Trans.Reader
import qualified EffectZoo.Scenario.FileSizes.Shared
                                               as Shared

data File m k = TryFileSize FilePath (Maybe Int -> m k)
  deriving (Functor, Generic1)

instance Effect File
instance HFunctor File

tryFileSize :: Has File sig m => FilePath -> m (Maybe Int)
tryFileSize path = send (TryFileSize path pure)

newtype FileIOC m a = FileIOC
  { runFileIOC :: m a
  } deriving (Functor, Applicative, Monad, MonadIO)

instance (Algebra sig m, MonadIO m) => Algebra (File :+: sig) (FileIOC m) where
  alg (L (TryFileSize path k)) = FileIOC $ do
    msize <- liftIO (Shared.tryGetFileSize path)
    runFileIOC (k msize)
  alg (R other) = FileIOC (alg (handleCoercible other))
