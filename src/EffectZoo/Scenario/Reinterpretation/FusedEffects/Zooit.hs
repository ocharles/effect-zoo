{-# language KindSignatures, TypeOperators, FlexibleInstances, MultiParamTypeClasses, UndecidableInstances, DeriveFunctor, FlexibleContexts #-}
module EffectZoo.Scenario.Reinterpretation.FusedEffects.Zooit where

import           Data.Coerce
import           Control.Effect
import           Control.Effect.Carrier
import           Control.Effect.Sum
import           EffectZoo.Scenario.Reinterpretation.FusedEffects.HTTP
import           EffectZoo.Scenario.Reinterpretation.FusedEffects.Logging

data Zooit (m :: * -> *) k
  = ListScenarios ( [String] -> k )
  deriving ( Functor )

listScenarios :: (Member Zooit sig, Carrier sig m) => m [String]
listScenarios = send (ListScenarios ret)

instance HFunctor Zooit where
  hmap _ = coerce

instance Effect Zooit where
  handle state handler (ListScenarios k) = ListScenarios (handler . (<$ state) . k)

newtype LoggedHTTPC m a = LoggedHTTPC { runLoggedHTTPC :: m a }

instance (Carrier sig m, Effect sig, Monad m, Member Logging sig, Member HTTP sig) => Carrier (Zooit :+: sig) (LoggedHTTPC m) where
  ret = LoggedHTTPC . ret
  eff =
    LoggedHTTPC
      . handleSum
          ( eff . handleCoercible )
          ( \( ListScenarios k ) -> do
              logMsg "Fetching a list of scenarios"
              scenarios <- lines <$> httpGET "/scenarios"
              runLoggedHTTPC (k scenarios)
          )

toLoggedHTTP
  :: (Effect sig, Carrier sig m, Member Logging sig, Member HTTP sig, Monad m)
  => Eff (LoggedHTTPC m) a
  -> m a
toLoggedHTTP m = runLoggedHTTPC (interpret m)
