{-# LANGUAGE DeriveFunctor, FlexibleContexts, FlexibleInstances, KindSignatures, LambdaCase, MultiParamTypeClasses, TypeOperators, UndecidableInstances #-}
module EffectZoo.Scenario.NoInline.FusedEffects.Increment where

import           Control.Effect.Carrier
import           Control.Effect.Sum
import           Control.Effect.Internal
import           Data.Coerce

data Increment (m :: * -> *) k
  = Increment k

instance Functor (Increment m) where
  fmap f ( Increment k ) = Increment (f k)
  {-# NOINLINE fmap #-}

instance HFunctor Increment where
  hmap _ = coerce
  {-# NOINLINE hmap #-}

instance Effect Increment where
  handle increment handler (Increment k) = Increment (handler . (<$ increment) $ k)
  {-# NOINLINE handle #-}

increment :: (Member Increment sig, Carrier sig m, Functor m) => m ()
increment = send (Increment (ret ()))
{-# NOINLINE increment #-}

runIncrement
  :: (Carrier sig m, Effect sig, Functor m) => Eff (IncrementC m) a -> m Int
runIncrement m = fmap fst (runIncrementC (interpret m) 0)
{-# NOINLINE runIncrement #-}

newtype IncrementC m a = IncrementC { runIncrementC :: Int -> m (Int, a) }

instance (Carrier sig m, Effect sig) => Carrier (Increment :+: sig) (IncrementC m) where
  ret a = IncrementC (\ s -> ret (s, a))
  {-# NOINLINE ret #-}

  eff op = IncrementC (\ s -> handleSum (eff . handleState s runIncrementC) (\case
    Increment k -> runIncrementC  k    (s + 1)) op)
  {-# NOINLINE eff #-}
