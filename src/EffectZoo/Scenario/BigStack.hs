module EffectZoo.Scenario.BigStack where

import Criterion
import qualified EffectZoo.Scenario.BigStack.FreerSimple.Main as FreerSimple
import qualified EffectZoo.Scenario.BigStack.FusedEffects.Main as FusedEffects
import qualified EffectZoo.Scenario.BigStack.MTL.Main as MTL
import qualified EffectZoo.Scenario.BigStack.SimpleEffects.Main as SimpleEffects


benchmarks :: Benchmark
benchmarks =
  bgroup
    "EffectZoo.Scenario.BigStack"
    ( do
        ( name, bigStacks ) <-
          [ ( "EffectZoo.Scenario.BigStack.FreerSimple.Main" , [ ( 0, FreerSimple.bigStack0 )
                                                               , ( 1, FreerSimple.bigStack1 )
                                                               , ( 5, FreerSimple.bigStack5 )
                                                               , ( 10, FreerSimple.bigStack10 )
                                                               ] )
          , ( "EffectZoo.Scenario.BigStack.FusedEffects.Main" , [ ( 0, FusedEffects.bigStack0 )
                                                                , ( 1, FusedEffects.bigStack1 )
                                                                , ( 5, FusedEffects.bigStack5 )
                                                                , ( 10, FusedEffects.bigStack10 )
                                                                ] )
          , ( "EffectZoo.Scenario.BigStack.MTL.Main" , [ ( 0, MTL.bigStack0 )
                                                       , ( 1, MTL.bigStack1 )
                                                       , ( 5, MTL.bigStack5 )
                                                       , ( 10, MTL.bigStack10 )
                                                       ] )
          , ( "EffectZoo.Scenario.BigStack.SimpleEffects.Main" , [ ( 0, SimpleEffects.bigStack0 )
                                                                 , ( 1, SimpleEffects.bigStack1 )
                                                                 , ( 5, SimpleEffects.bigStack5 )
                                                                 , ( 10, SimpleEffects.bigStack10 )
                                                                 ] )
          ]

        return $ bgroup name $ do
          ( n, bigStack ) <-
            bigStacks

          return ( bench ( show n ) ( whnf bigStack 0 ) )
    )
