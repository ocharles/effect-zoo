{-# language DeriveAnyClass, DeriveGeneric, FlexibleContexts, NoMonomorphismRestriction #-}

module EffectZoo.Scenario.CountDown.SimpleEffects.IntState where

import           Control.Effects
import           Control.Monad
import           GHC.Generics

data IntState m =
  IntState { _get :: m Int
           , _put :: Int -> m ()
           }
  deriving (Generic, Effect)

get :: MonadEffect IntState m => m Int
put :: MonadEffect IntState m => Int -> m ()
IntState get put = effect

runIntState
  :: Monad m => Int -> RuntimeImplemented IntState (IntStateT m) a -> m (a, Int)
runIntState s m = runIntStateT
  (implement
    IntState
      { _get = IntStateT $ \s -> return (s, s)
      , _put = \s -> IntStateT $ \_ -> return ((), s)
      }
    m
  )
  s
{-# INLINE runIntState #-}

newtype IntStateT m a = IntStateT { runIntStateT :: Int -> m (a, Int) }

instance Monad m => Functor (IntStateT m) where
  fmap = liftM

instance Monad m => Applicative (IntStateT m) where
  pure = return
  (<*>) = ap

instance Monad m => Monad (IntStateT m) where
  return a = IntStateT $ \s -> return (a, s)
  IntStateT x >>= f =
    IntStateT $ \s -> do
      (x', s') <- x s
      runIntStateT (f x') s'
