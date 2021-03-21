module EffectZoo.Scenario.Reinterpretation where

import           Criterion
import qualified EffectZoo.Scenario.Reinterpretation.FreerSimple.Main
                                               as FreerSimple
import qualified EffectZoo.Scenario.Reinterpretation.FusedEffects.Main
                                               as FusedEffects
import qualified EffectZoo.Scenario.Reinterpretation.Polysemy.Main
                                               as Polysemy
import qualified EffectZoo.Scenario.Reinterpretation.SimpleEffects.Main
                                               as SimpleEffects
import qualified EffectZoo.Scenario.Reinterpretation.EvEff.Main
                                               as EvEff

benchmarks :: [Benchmark]
benchmarks = do
  (name, program) <-
    [ ("freer-simple"  , FreerSimple.listScenarios)
    , ("fused-effects" , FusedEffects.listScenarios)
    , ("simple-effects", SimpleEffects.listScenarios)
    , ("polysemy", Polysemy.listScenarios)
    , ("eveff", EvEff.listScenarios)
    ]
  pure $ bgroup name $ flip map [1, 10, 100] $ \n ->
    bench (show n) (nf program n)
