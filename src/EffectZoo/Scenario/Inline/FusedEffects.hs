{-# LANGUAGE DeriveFunctor, FlexibleContexts, FlexibleInstances, KindSignatures, LambdaCase, MultiParamTypeClasses, TypeOperators, UndecidableInstances #-}
module EffectZoo.Scenario.Inline.FusedEffects (increments) where

import           Control.Monad
import           Control.Effect
import           Control.Effect.Carrier
import           Control.Effect.Sum
import           Control.Effect.Internal
import           Data.Coerce

data Increment (m :: * -> *) k
  = Increment k

instance Functor (Increment m) where
  fmap f ( Increment k ) = Increment (f k)
  {-# INLINE fmap #-}

instance HFunctor Increment where
  hmap _ = coerce
  {-# INLINE hmap #-}

instance Effect Increment where
  handle increment handler (Increment k) = Increment (handler . (<$ increment) $ k)
  {-# INLINE handle #-}

increment :: (Member Increment sig, Carrier sig m, Functor m) => m ()
increment = send (Increment (ret ()))
{-# INLINE increment #-}

runIncrement
  :: (Carrier sig m, Effect sig, Functor m) => Eff (IncrementC m) a -> m Int
runIncrement m = fmap fst (runIncrementC (interpret m) 0)
{-# INLINE runIncrement #-}

newtype IncrementC m a = IncrementC { runIncrementC :: Int -> m (Int, a) }

instance (Carrier sig m, Effect sig) => Carrier (Increment :+: sig) (IncrementC m) where
  ret a = IncrementC (\ s -> ret (s, a))
  {-# INLINE ret #-}

  eff op = IncrementC (\ s -> handleSum (eff . handleState s runIncrementC) (\case
    Increment k -> runIncrementC  k    (s + 1)) op)
  {-# INLINE eff #-}

increments :: Int -> IO Int
increments n = runM ( runIncrement ( replicateM_ n increment ) )
