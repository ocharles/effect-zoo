module EffectZoo.Scenario.FileSizes where

import           Criterion
import qualified EffectZoo.Scenario.FileSizes.Eff.Main
                                               as Eff
import qualified EffectZoo.Scenario.FileSizes.FreerSimple.Main
                                               as FreerSimple
import qualified EffectZoo.Scenario.FileSizes.FusedEffects.Main
                                               as FusedEffects
import qualified EffectZoo.Scenario.FileSizes.MTL.Main
                                               as MTL
import qualified EffectZoo.Scenario.FileSizes.Polysemy.Main
                                               as Polysemy
import qualified EffectZoo.Scenario.FileSizes.Reference
                                               as Reference
import qualified EffectZoo.Scenario.FileSizes.SimpleEffects.Main
                                               as SimpleEffects

benchmarks :: [Benchmark]
benchmarks = do
  ( implementation, go ) <-
    [ ( "simple-effects" , SimpleEffects.calculateFileSizes )
    , ( "freer-simple", FreerSimple.calculateFileSizes )
    , ( "fused-effects" , FusedEffects.calculateFileSizes )
    , ( "mtl" , MTL.calculateFileSizes )
    , ( "polysemy" , Polysemy.calculateFileSizes )
    , ( "eff" , Eff.calculateFileSizes )
    , ( "Reference", Reference.calculateFileSizes )
    ]

  pure $ bgroup implementation $ flip map [1, 10, 100] $ \n ->
    bench (show n) (nfAppIO go (take n files))

files :: [FilePath]
files = repeat "effect-zoo.cabal"
