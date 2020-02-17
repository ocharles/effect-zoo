module Main where


import qualified Data.ByteString.Lazy          as BS
import qualified Data.Csv                      as Csv
import qualified EffectZoo.Scenario.BigStack   as BigStack
import qualified EffectZoo.Scenario.CountDown  as CountDown
import qualified EffectZoo.Scenario.FileSizes  as FileSizes
import qualified EffectZoo.Scenario.Reinterpretation
                                               as Reinterpretation
-- import           Statistics.Types

import Criterion.Main
import Criterion.Types
import Data.Foldable

main :: IO ()
main = for_
    [ ("big-stack", BigStack.benchmarks)
    , ("countdown", CountDown.benchmarks)
    , ("file-sizes", FileSizes.benchmarks)
    , ("reinterpretation", Reinterpretation.benchmarks)
    ]
    (\(name, scenario) -> do
      let config = defaultConfig
            { reportFile = Just (name <> ".html") }
      defaultMainWith config scenario
      -- reports <- for
      --   scenario
      --   (\(implementation, scenario, benchmarkable) -> do
      --     Report { reportAnalysis = SampleAnalysis { anMean = e@Estimate { estPoint = mean } } } <-
      --       Criterion.benchmark' benchmarkable
      --
      --     let (meanL, meanU) = confidenceInterval e
      --
      --     return (implementation, scenario, mean, meanL, meanU)
      --   )
      --
      -- BS.writeFile csvFile (Csv.encode reports)
    )
