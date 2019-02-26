module EffectZoo.Scenario.BigStack where

import           Criterion
import qualified EffectZoo.Scenario.BigStack.FreerSimple.Main
                                               as FreerSimple
import qualified EffectZoo.Scenario.BigStack.FusedEffects.Main
                                               as FusedEffects
import qualified EffectZoo.Scenario.BigStack.MTL.Main
                                               as MTL
import qualified EffectZoo.Scenario.BigStack.SimpleEffects.Main
                                               as SimpleEffects

benchmarks :: [ ( String, String, Benchmarkable ) ]
benchmarks = do
  ( implementation, bigStacks ) <-
    [ ( "freer-simple"
      , [ (0 , FreerSimple.bigStack0)
        , (1 , FreerSimple.bigStack1)
        , (5 , FreerSimple.bigStack5)
        , (10, FreerSimple.bigStack10)
        ]
      )
    , ( "fused-effects"
      , [ (0 , FusedEffects.bigStack0)
        , (1 , FusedEffects.bigStack1)
        , (5 , FusedEffects.bigStack5)
        , (10, FusedEffects.bigStack10)
        ]
      )
    , ( "mtl"
      , [ (0 , MTL.bigStack0)
        , (1 , MTL.bigStack1)
        , (5 , MTL.bigStack5)
        , (10, MTL.bigStack10)
        ]
      )
    , ( "simple-effects"
      , [ (0 , SimpleEffects.bigStack0)
        , (1 , SimpleEffects.bigStack1)
        , (5 , SimpleEffects.bigStack5)
        , (10, SimpleEffects.bigStack10)
        ]
      )
    ]

  ( stackSize, go ) <-
    bigStacks

  return ( implementation, show stackSize ++ " layers", whnf go 0 )
