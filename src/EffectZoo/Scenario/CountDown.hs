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
import qualified EffectZoo.Scenario.CountDown.Polysemy.Main
                                               as Polysemy
import qualified EffectZoo.Scenario.CountDown.Reference
                                               as Reference
import qualified EffectZoo.Scenario.CountDown.SimpleEffects.Main
                                               as SimpleEffects
import qualified EffectZoo.Scenario.CountDown.EvEff.Main
                                               as EvEff

benchmarks :: [Benchmark]
benchmarks = do
  (implementation, countDown) <-
    [ ("mtl (lazy)"    , nf MTLLazyStateT.countDown)
    , ("mtl (strict)"  , nf MTLStrictStateT.countDown)
    , ("freer-simple"  , nf FreerSimple.countDown)
    , ("simple-effects", nf SimpleEffects.countDown)
    , ("fused-effects" , nf FusedEffects.countDown)
    , ("polysemy"      , nf Polysemy.countDown)
    , ("Reference"     , nf Reference.countDown)
    , ("eveff"         , nf EvEff.countDown)
    ]

  pure $ bgroup implementation $ flip map [100, 1000] $ \n ->
    bench (show n) (countDown n)
