{-# LANGUAGE DataKinds, FlexibleContexts, GADTs, TypeOperators,
  KindSignatures, FlexibleInstances, MultiParamTypeClasses,
  UndecidableInstances, DeriveFunctor, GeneralizedNewtypeDeriving #-}

module EffectZoo.Scenario.FileSizes.FusedEffects.Logging where

import Control.Effect
import Control.Effect.Carrier
import Control.Effect.Sum
import Control.Monad.IO.Class
import Control.Monad.Trans.Reader
import Data.Coerce
import Data.IORef
import qualified EffectZoo.Scenario.FileSizes.Shared as Shared

data Logging (m :: * -> *) k =
  LogMsg String
         k
  deriving (Functor)

instance HFunctor Logging where
  hmap _ = coerce

instance Effect Logging where
  handle state handler (LogMsg m k) = LogMsg m (handler (k <$ state))

logMsg :: (Member Logging sig, Carrier sig m) => String -> m ()
logMsg msg = send (LogMsg msg (ret ()))

newtype LogIOC m a = LogIOC
  { unLogIOC :: ReaderT (IORef [String]) m a
  } deriving (Functor, Applicative, Monad, MonadIO)

runLogIOC :: IORef [String] -> LogIOC m a -> m a
runLogIOC r (LogIOC (ReaderT m)) = m r

instance (Carrier sig m, MonadIO m) =>
         Carrier (Logging :+: sig) (LogIOC m) where
  ret m = LogIOC (ReaderT (\_ -> ret m))
  eff x =
    LogIOC $
    ReaderT $ \r ->
      handleSum
        (eff . handleReader r (\m r' -> runLogIOC r' m))
        (\t ->
           case t of
             LogMsg msg k -> do
               liftIO (Shared.logToIORef r msg)
               runLogIOC r k)
        x

runLogIOC2 ::
     (MonadIO m, Carrier sig m, Effect sig)
  => IORef [String]
  -> Eff (LogIOC m) a
  -> m a
runLogIOC2 r = runLogIOC r . interpret
