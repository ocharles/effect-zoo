module EffectZoo.Scenario.Inline where

import           Criterion
import qualified EffectZoo.Scenario.Inline.FreerSimple
                                               as FreerSimple
import qualified EffectZoo.Scenario.Inline.FusedEffects
                                               as FusedEffects
import qualified EffectZoo.Scenario.Inline.SimpleEffects
                                               as SimpleEffects

benchmarks :: Benchmark
benchmarks = bgroup
  "EffectZoo.Scenario.Inline"
  (do
    (name, noops) <-
      [ ("EffectZoo.Scenario.Inline.FreerSimple", nfIO . FreerSimple.noops)
      , ("EffectZoo.Scenario.Inline.FusedEffects", nfIO . FusedEffects.increments)
      , ("EffectZoo.Scenario.Inline.SimpleEffects", nfIO . SimpleEffects.increments)
      ]
    return $ bgroup name $ do
      n <- [10000000]
      return (bench (show n) (noops n))
  )
