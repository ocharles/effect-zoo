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

benchmarks :: Benchmark
benchmarks = bgroup
  "EffectZoo.Scenario.CountDown"
  (do
    (name, countDown) <-
      [ ("EffectZoo.Scenario.CountDown.MTL.LazyStateT", nf MTLLazyStateT.countDown)
      , ( "EffectZoo.Scenario.CountDown.MTL.StrictStateT"
        , nf MTLStrictStateT.countDown
        )
      , ("EffectZoo.Scenario.CountDown.FreerSimple.Main", nf FreerSimple.countDown)
      , ( "EffectZoo.Scenario.CountDown.SimpleEffects.Main"
        , nf SimpleEffects.countDown
        )
      , ( "EffectZoo.Scenario.CountDown.FusedEffects.Main"
        , nf FusedEffects.countDown
        )
      , ("EffectZoo.Scenario.CountDown.Reference.Main", nf Reference.countDown)
      ]
    return $ bgroup name $ do
      n <- [100, 1000, 1000000]
      return (bench (show n) (countDown n))
  )
