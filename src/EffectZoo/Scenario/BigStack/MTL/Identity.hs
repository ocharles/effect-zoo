{-# language GeneralizedNewtypeDeriving, UndecidableInstances, FlexibleInstances, MultiParamTypeClasses #-}
module EffectZoo.Scenario.BigStack.MTL.Identity where

import           Control.Monad
import           Control.Monad.Reader.Class
import           Control.Monad.State.Class

newtype IdentityT m a = IdentityT { runIdentityT :: m a }
  deriving (Functor, Applicative, Monad)

instance MonadState s m => MonadState s (IdentityT m) where
  get = IdentityT get
  put = IdentityT . put
