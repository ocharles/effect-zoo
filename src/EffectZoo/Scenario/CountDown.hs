module EffectZoo.Scenario.CountDown where

import           Criterion
import qualified EffectZoo.Scenario.CountDown.FreerSimple.Main
                                               as FreerSimple
import qualified EffectZoo.Scenario.CountDown.FusedEffects.Main
                                               as FusedEffects
import qualified EffectZoo.Scenario.CountDown.MTL.LazyStateT
                                               as MTLLazyStateT
import qualified EffectZoo.Scenario.CountDown.MTL.StrictStateT
                                               as MTLStrictStateT
import qualified EffectZoo.Scenario.CountDown.Reference
                                               as Reference
import qualified EffectZoo.Scenario.CountDown.SimpleEffects.Main
                                               as SimpleEffects

benchmarks :: [(String, String, Benchmarkable)]
benchmarks = do
  (implementation, countDown) <-
    [ ("mtl (lazy)"    , nf MTLLazyStateT.countDown)
    , ("mtl (strict)"  , nf MTLStrictStateT.countDown)
    , ("freer-simple"  , nf FreerSimple.countDown)
    , ("simple-effects", nf SimpleEffects.countDown)
    , ("fused-effects" , nf FusedEffects.countDown)
    , ("Reference"     , nf Reference.countDown)
    ]

  n <- [100, 1000, 1000000]

  return (implementation, show n, countDown n)
