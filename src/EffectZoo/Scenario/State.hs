module EffectZoo.Scenario.State where

import Criterion
import qualified EffectZoo.Scenario.State.MTL.LazyStateT as MTLLazyStateT
import qualified EffectZoo.Scenario.State.MTL.StrictStateT as MTLStrictStateT
import qualified EffectZoo.Scenario.State.FreerSimple.Main as FreerSimple
import qualified EffectZoo.Scenario.State.SimpleEffects.Main as SimpleEffects
import qualified EffectZoo.Scenario.State.FusedEffects.Main as FusedEffects


benchmarks :: Benchmark
benchmarks =
  bgroup
    "EffectZoo.Scenario.State"
    ( do
        ( name, countDown ) <-
          [ ( "EffectZoo.Scenario.State.MTL.LazyStateT", MTLLazyStateT.countDown )
          , ( "EffectZoo.Scenario.State.MTL.StrictStateT", MTLStrictStateT.countDown )
          , ( "EffectZoo.Scenario.State.FreerSimple.Main", FreerSimple.countDown )
          , ( "EffectZoo.Scenario.State.SimpleEffects.Main", SimpleEffects.countDown )
          , ( "EffectZoo.Scenario.State.FusedEffects.Main", FusedEffects.countDown )
          ]

        return $ bgroup name $ do
          n <-
            [ 100, 1000, 1000000 ]

          return ( bench ( show n ) ( whnf countDown n ) )
    )
