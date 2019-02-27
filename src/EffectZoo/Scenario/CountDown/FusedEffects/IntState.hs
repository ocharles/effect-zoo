{-# language DeriveFunctor, KindSignatures, TypeOperators, FlexibleInstances, MultiParamTypeClasses, UndecidableInstances, FlexibleContexts #-}

module EffectZoo.Scenario.CountDown.FusedEffects.IntState where

import           Control.Effect
import           Control.Effect.Carrier
import           Control.Effect.Sum
import           Data.Coerce

data IntState (m :: * -> *) k
  = Get (Int -> k)
  | Put Int k
  deriving (Functor)

instance HFunctor IntState where
  hmap _ = coerce

instance Effect IntState where
  handle state handler (Get k) = Get (handler . (<$ state) . k)
  handle state handler (Put i k) = Put i (handler (k <$ state))

newtype IntStateC m a = IntStateC { runIntStateC :: Int -> m (Int, a) }

instance (Carrier sig m, Effect sig) => Carrier (IntState :+: sig) (IntStateC m) where
  ret a = IntStateC (\s -> ret (s, a))

  eff op =
    IntStateC
      (\s ->
         handleSum
           (eff . handleState s runIntStateC)
           (\e ->
              case e of
                Get k -> runIntStateC (k s) s
                Put s' k -> runIntStateC k s'
           )
           op
      )

runState
  :: (Effect sig, Carrier sig m) => Int -> Eff (IntStateC m) a -> m (Int, a)
runState i m = runIntStateC (interpret m) i


get :: (Member IntState sig, Carrier sig m) => m Int
get = send (Get ret)


put :: (Member IntState sig, Carrier sig m) => Int -> m ()
put i = send (Put i (ret ()))
