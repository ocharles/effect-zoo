module EffectZoo.Scenario.NoInline where

import           Criterion
import qualified EffectZoo.Scenario.NoInline.FreerSimple.Main
                                               as FreerSimple
import qualified EffectZoo.Scenario.NoInline.FusedEffects.Main
                                               as FusedEffects
import qualified EffectZoo.Scenario.NoInline.SimpleEffects.Main
                                               as SimpleEffects

benchmarks :: Benchmark
benchmarks = bgroup
  "EffectZoo.Scenario.NoInline"
  (do
    (name, noops) <-
      [ ( "EffectZoo.Scenario.NoInline.FreerSimple.Main"
        , nfIO . FreerSimple.noops
        )
      , ( "EffectZoo.Scenario.NoInline.FusedEffects.Main"
        , nfIO . FusedEffects.increments
        )
      , ( "EffectZoo.Scenario.NoInline.SimpleEffects.Main"
        , nfIO . SimpleEffects.increments
        )
      ]
    return $ bgroup name $ do
      n <- [10000000]
      return (bench (show n) (noops n))
  )
