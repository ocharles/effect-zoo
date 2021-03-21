{-# LANGUAGE DataKinds, FlexibleContexts, GADTs, TypeOperators,
  KindSignatures, FlexibleInstances, MultiParamTypeClasses,
  UndecidableInstances, DeriveFunctor, GeneralizedNewtypeDeriving #-}

module EffectZoo.Scenario.FileSizes.FusedEffects.Logging where

import GHC.Generics (Generic1)
import "fused-effects" Control.Algebra
import "fused-effects" Control.Effect.Sum
import           Control.Monad.IO.Class
import           Control.Monad.Trans.Reader
import           Data.IORef
import qualified EffectZoo.Scenario.FileSizes.Shared
                                               as Shared

data Logging m k = LogMsg String (m k)
  deriving (Functor, Generic1)

logMsg :: Has Logging sig m => String -> m ()
logMsg msg = send (LogMsg msg (pure ()))

instance HFunctor Logging
instance Effect Logging

newtype LogIOC m a = LogIOC
  { unLogIOC :: ReaderT (IORef [String]) m a
  } deriving (Functor, Applicative, Monad, MonadIO)

runLogIOC :: IORef [String] -> LogIOC m a -> m a
runLogIOC r (LogIOC (ReaderT m)) = m r

instance (Algebra sig m, MonadIO m) => Algebra (Logging :+: sig) (LogIOC m) where
  alg (L (LogMsg msg k)) =
    LogIOC (ReaderT $ \r -> liftIO (Shared.logToIORef r msg)) >> k
  alg (R other) = LogIOC (alg (R (handleCoercible other)))
