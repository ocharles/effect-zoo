module EffectZoo.Scenario.Reinterpretation where

import           Criterion
import qualified EffectZoo.Scenario.Reinterpretation.FreerSimple.Main
                                               as FreerSimple

benchmarks :: Benchmark
benchmarks = bgroup
  "EffectZoo.Scenario.Reinterpretation"
  (do
    (name, program) <-
      [ ( "EffectZoo.Scenario.Reinterpretation.FreerSimple.Main"
        , FreerSimple.listScenarios
        )
      ]

    return (bench name (nfIO program))
  )
