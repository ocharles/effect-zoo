{-# language KindSignatures, TypeOperators, FlexibleInstances, MultiParamTypeClasses, UndecidableInstances, DeriveFunctor, FlexibleContexts #-}
module EffectZoo.Scenario.Reinterpretation.FusedEffects.Zooit where

import GHC.Generics (Generic1)
import "fused-effects" Control.Algebra
import "fused-effects" Control.Effect.Sum
import           EffectZoo.Scenario.Reinterpretation.FusedEffects.HTTP
import           EffectZoo.Scenario.Reinterpretation.FusedEffects.Logging

data Zooit m k = ListScenarios ([String] -> m k)
  deriving (Functor, Generic1)

listScenarios :: Has Zooit sig m => m [String]
listScenarios = send (ListScenarios pure)

instance Effect Zooit
instance HFunctor Zooit

newtype LoggedHTTPC m a = LoggedHTTPC { runLoggedHTTPC :: m a }
  deriving (Functor, Applicative, Monad)

instance (Monad m, Has Logging sig m, Has HTTP sig m) => Algebra (Zooit :+: sig) (LoggedHTTPC m) where
  alg (L (ListScenarios k)) = LoggedHTTPC $ do
    logMsg "Fetching a list of scenarios"
    scenarios <- lines <$> httpGET "/scenarios"
    runLoggedHTTPC (k scenarios)
  alg (R other) = LoggedHTTPC (alg (handleCoercible other))

toLoggedHTTP :: LoggedHTTPC m a -> m a
toLoggedHTTP = runLoggedHTTPC
