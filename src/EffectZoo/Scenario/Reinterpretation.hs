module EffectZoo.Scenario.Reinterpretation where

import           Criterion
import qualified EffectZoo.Scenario.Reinterpretation.FreerSimple.Main
                                               as FreerSimple
import qualified EffectZoo.Scenario.Reinterpretation.FusedEffects.Main
                                               as FusedEffects
import qualified EffectZoo.Scenario.Reinterpretation.SimpleEffects.Main
                                               as SimpleEffects

benchmarks :: [(String, String, Benchmarkable)]
benchmarks = do
  (name, program) <-
    [ ("freer-simple"  , FreerSimple.listScenarios)
    , ("fused-effects" , FusedEffects.listScenarios)
    , ("simple-effects", SimpleEffects.listScenarios)
    ]

  n <- [1, 10, 100]

  return (name, show n, nfIO (program n))
