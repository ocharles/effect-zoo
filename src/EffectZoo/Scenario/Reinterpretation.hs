module EffectZoo.Scenario.Reinterpretation where

import           Criterion
import qualified EffectZoo.Scenario.Reinterpretation.FreerSimple.Main
                                               as FreerSimple

benchmarks :: [(String, String, Benchmarkable)]
benchmarks = do
  (name, program) <- [("freer-simple", FreerSimple.listScenarios)]

  return (name, "", nfIO program)
