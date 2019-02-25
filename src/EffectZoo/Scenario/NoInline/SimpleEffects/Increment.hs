{-# language FlexibleContexts, NamedFieldPuns, NoMonomorphismRestriction #-}

module EffectZoo.Scenario.NoInline.SimpleEffects.Increment where

import           Control.Effects
import           Control.Monad.Trans.Class

data Increment m = Increment { _increment :: m () }

instance Effect Increment where
  liftThrough Increment{ _increment } =
    Increment { _increment = lift _increment }
  {-# NOINLINE liftThrough #-}

  mergeContext m =
    Increment { _increment = m >>= \Increment{ _increment } -> _increment }
  {-# NOINLINE mergeContext #-}

increment :: MonadEffect Increment m => m ()
Increment increment = effect
{-# NOINLINE increment #-}


runIncrement :: Monad m => RuntimeImplemented Increment m a -> m a
runIncrement = implement Increment {_increment = return ()}
{-# NOINLINE runIncrement #-}
