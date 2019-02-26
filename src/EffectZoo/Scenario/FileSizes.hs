module EffectZoo.Scenario.FileSizes where

import           Criterion
import qualified EffectZoo.Scenario.FileSizes.FreerSimple.Main
                                               as FreerSimple
import qualified EffectZoo.Scenario.FileSizes.FusedEffects.Main
                                               as FusedEffects
import qualified EffectZoo.Scenario.FileSizes.MTL.Main
                                               as MTL
import qualified EffectZoo.Scenario.FileSizes.Reference
                                               as Reference
import qualified EffectZoo.Scenario.FileSizes.SimpleEffects.Main
                                               as SimpleEffects

benchmarks :: [ ( String, String, Benchmarkable ) ]
benchmarks = do
  ( implementation, go ) <-
    [ ( "simple-effects" , SimpleEffects.calculateFileSizes )
    , ( "freer-simple", FreerSimple.calculateFileSizes )
    , ( "fused-effects" , FusedEffects.calculateFileSizes )
    , ( "mtl" , MTL.calculateFileSizes )
    , ( "Reference", Reference.calculateFileSizes )
    ]

  n <-
   [1, 10, 100]

  return ( implementation, ( show n ++ " files" ), nfAppIO go ( take n files ) )


files :: [FilePath]
files = repeat "effect-zoo.cabal"
