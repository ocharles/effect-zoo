module EffectZoo.Scenario.State where

import Criterion
import qualified EffectZoo.Scenario.State.Reference as Reference
import qualified EffectZoo.Scenario.State.MTL.LazyStateT as MTLLazyStateT
import qualified EffectZoo.Scenario.State.MTL.StrictStateT as MTLStrictStateT
import qualified EffectZoo.Scenario.State.FreerSimple.Main as FreerSimple
import qualified EffectZoo.Scenario.State.SimpleEffects.Main as SimpleEffects
import qualified EffectZoo.Scenario.State.FusedEffects.Main as FusedEffects
import qualified EffectZoo.Scenario.State.RIO.Main as RIO


benchmarks :: Benchmark
benchmarks =
  bgroup
    "EffectZoo.Scenario.State"
    ( do
        ( name, countDown ) <-
          [ ( "EffectZoo.Scenario.State.MTL.LazyStateT", nf MTLLazyStateT.countDown )
          , ( "EffectZoo.Scenario.State.MTL.StrictStateT", nf MTLStrictStateT.countDown )
          , ( "EffectZoo.Scenario.State.FreerSimple.Main", nf FreerSimple.countDown )
          , ( "EffectZoo.Scenario.State.SimpleEffects.Main", nf SimpleEffects.countDown )
          , ( "EffectZoo.Scenario.State.FusedEffects.Main", nf FusedEffects.countDown )
          , ( "EffectZoo.Scenario.State.Reference.Main", nf Reference.countDown )
          , ( "EffectZoo.Scenario.State.RIO.Main", nfIO . RIO.countDown )
          ]

        return $ bgroup name $ do
          n <-
            [ 100, 1000, 1000000 ]

          return ( bench ( show n ) ( countDown n ) )
    )
