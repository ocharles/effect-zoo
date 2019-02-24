{-# LANGUAGE DataKinds, FlexibleContexts, GADTs, TypeOperators,
  KindSignatures, FlexibleInstances, MultiParamTypeClasses,
  UndecidableInstances, DeriveFunctor, GeneralizedNewtypeDeriving #-}

module EffectZoo.Scenario.FileSizes.FusedEffects.File where

import Control.Effect
import Control.Effect.Carrier
import Control.Effect.Sum
import Control.Monad.IO.Class
import Control.Monad.Trans.Reader
import Data.Coerce
import qualified EffectZoo.Scenario.FileSizes.Shared as Shared

data File (m :: * -> *) k =
  TryFileSize FilePath
              (Maybe Int -> k)
  deriving (Functor)

instance Effect File where
  handle state handler (TryFileSize p k) =
    TryFileSize p (handler . (<$ state) . k)

instance HFunctor File where
  hmap _ = coerce

tryFileSize :: (Member File sig, Carrier sig m) => FilePath -> m (Maybe Int)
tryFileSize path = send (TryFileSize path ret)

newtype FileIOC m a = FileIOC
  { runFileIOC :: m a
  } deriving (Functor, Applicative, Monad, MonadIO)

instance (Carrier sig m, MonadIO m) => Carrier (File :+: sig) (FileIOC m) where
  ret = FileIOC . ret
  eff =
    FileIOC .
    handleSum
      (eff . handleCoercible)
      (\t ->
         case t of
           TryFileSize path k -> do
             msize <- liftIO (Shared.tryGetFileSize path)
             runFileIOC (k msize))

runFileIOC2 ::
     (MonadIO m, Carrier sig m, Effect sig) => Eff (FileIOC m) a -> m a
runFileIOC2 = runFileIOC . interpret
