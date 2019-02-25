{-# language FlexibleContexts, NamedFieldPuns, NoMonomorphismRestriction #-}

module EffectZoo.Scenario.Inline.SimpleEffects (increments) where

import           Control.Effects
import           Control.Monad
import           Control.Monad.Trans.Class

data Increment m = Increment { _increment :: m () }

instance Effect Increment where
  liftThrough Increment{ _increment } =
    Increment { _increment = lift _increment }
  {-# INLINE liftThrough #-}

  mergeContext m =
    Increment { _increment = m >>= \Increment{ _increment } -> _increment }
  {-# INLINE mergeContext #-}

increment :: MonadEffect Increment m => m ()
Increment increment = effect
{-# INLINE increment #-}


runIncrement :: Monad m => RuntimeImplemented Increment m a -> m a
runIncrement = implement Increment {_increment = return ()}
{-# INLINE runIncrement #-}


increments :: Int -> IO ()
increments n = runIncrement ( replicateM_ n increment )
