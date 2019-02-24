module EffectZoo.Scenario.FileSizes where

import Criterion
import qualified EffectZoo.Scenario.FileSizes.FreerSimple.Main as FreerSimple
import qualified EffectZoo.Scenario.FileSizes.FusedEffects.Main as FusedEffects
import qualified EffectZoo.Scenario.FileSizes.MTL.Main as MTL
import qualified EffectZoo.Scenario.FileSizes.RIO.Main as RIO
import qualified EffectZoo.Scenario.FileSizes.Reference as Reference
import qualified EffectZoo.Scenario.FileSizes.SimpleEffects.Main as SimpleEffects

benchmarks :: Benchmark
benchmarks =
  bgroup
    "EffectZoo.Scenario.FileSizes"
    (do (name, program) <-
          [ ( "EffectZoo.Scenario.FileSizes.SimpleEffects.Main"
            , SimpleEffects.calculateFileSizes)
          , ( "EffectZoo.Scenario.FileSizes.FreerSimple.Main"
            , FreerSimple.calculateFileSizes)
          , ( "EffectZoo.Scenario.FileSizes.FusedEffects.Main"
            , FusedEffects.calculateFileSizes)
          , ("EffectZoo.Scenario.FileSizes.MTL.Main", MTL.calculateFileSizes)
          , ("EffectZoo.Scenario.FileSizes.RIO.Main", RIO.calculateFileSizes)
          , ( "EffectZoo.Scenario.FileSizes.Reference"
            , Reference.calculateFileSizes)
          ]
        return $
          bgroup name $ do
            n <- [1, 10, 100]
            return (bench (show n ++ " files") (nfIO (program (take n files)))))

files :: [FilePath]
files = repeat "effect-zoo.cabal"
