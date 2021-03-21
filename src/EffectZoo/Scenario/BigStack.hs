module EffectZoo.Scenario.BigStack where

import           Criterion
import qualified EffectZoo.Scenario.BigStack.FreerSimple.Main
                                               as FreerSimple
import qualified EffectZoo.Scenario.BigStack.FusedEffects.Main
                                               as FusedEffects
import qualified EffectZoo.Scenario.BigStack.MTL.Main
                                               as MTL
import qualified EffectZoo.Scenario.BigStack.Polysemy.Main
                                               as Polysemy
import qualified EffectZoo.Scenario.BigStack.SimpleEffects.Main
                                               as SimpleEffects
import qualified EffectZoo.Scenario.BigStack.EvEff.Main
                                               as EvEff

benchmarks :: [Benchmark]
benchmarks = do
  (implementation, bigStacks) <-
    [ ( "freer-simple"
      , [ (0 , FreerSimple.bigStack0)
        , (1 , FreerSimple.bigStack1)
        , (5 , FreerSimple.bigStack5)
        , (10, FreerSimple.bigStack10)
        -- , (20, FreerSimple.bigStack20)
        ]
      )
    , ( "fused-effects"
      , [ (0 , FusedEffects.bigStack0)
        , (1 , FusedEffects.bigStack1)
        , (5 , FusedEffects.bigStack5)
        , (10, FusedEffects.bigStack10)
        -- , (20, FusedEffects.bigStack20)
        ]
      )
    , ( "mtl"
      , [ (0 , MTL.bigStack0)
        , (1 , MTL.bigStack1)
        , (5 , MTL.bigStack5)
        , (10, MTL.bigStack10)
        -- , (20, MTL.bigStack20)
        ]
      )
    , ( "simple-effects"
      , [ (0 , SimpleEffects.bigStack0)
        , (1 , SimpleEffects.bigStack1)
        , (5 , SimpleEffects.bigStack5)
        , (10, SimpleEffects.bigStack10)
        -- , (20, SimpleEffects.bigStack20)
        ]
      )
    , ( "polysemy"
      , [ (0 , Polysemy.bigStack0)
        , (1 , Polysemy.bigStack1)
        , (5 , Polysemy.bigStack5)
        , (10, Polysemy.bigStack10)
        -- , (20, Eff.bigStack20)
        ]
      )
    , ( "eveff"
      , [ (0 , EvEff.bigStack0)
        , (1 , EvEff.bigStack1)
        , (5 , EvEff.bigStack5)
        , (10, EvEff.bigStack10)
        -- , (20, Eff.bigStack20)
        ]
      )
    ]

  pure $ bgroup implementation $ flip map bigStacks $ \(stackSize, go) ->
    bench (show stackSize) (nf go 0)
