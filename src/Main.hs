module Main where

import qualified Criterion
import           Criterion.Types
import qualified Data.ByteString.Lazy          as BS
import qualified Data.Csv                      as Csv
import           Data.Traversable                         ( for )
import qualified EffectZoo.Scenario.BigStack   as BigStack
import qualified EffectZoo.Scenario.CountDown  as CountDown
import qualified EffectZoo.Scenario.FileSizes  as FileSizes
import           EffectZoo.Scenario.Inline
import           EffectZoo.Scenario.NoInline
import qualified EffectZoo.Scenario.Reinterpretation
                                               as Reinterpretation
import           Statistics.Types

main :: IO ()
main = do
  for
    [ ("big-stack.csv"       , BigStack.benchmarks)
    , ("countdown.csv"       , CountDown.benchmarks)
    , ("file-sizes.csv"      , FileSizes.benchmarks)
    , ("reinterpretation.csv", Reinterpretation.benchmarks)
    ]
    (\(csvFile, scenario) -> do
      reports <- for
        scenario
        (\(implementation, scenario, benchmarkable) -> do
          Report { reportAnalysis = SampleAnalysis { anMean = e@Estimate { estPoint = mean } } } <-
            Criterion.benchmark' benchmarkable

          let (meanL, meanU) = confidenceInterval e

          return (implementation, scenario, mean, meanL, meanU)
        )

      BS.writeFile csvFile (Csv.encode reports)
    )

  return ()
