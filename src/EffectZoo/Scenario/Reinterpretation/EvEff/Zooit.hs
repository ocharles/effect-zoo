{-# language FlexibleContexts #-}
module EffectZoo.Scenario.Reinterpretation.EvEff.Zooit where

import           Control.Ev.Eff
import           EffectZoo.Scenario.Reinterpretation.EvEff.HTTP
import           EffectZoo.Scenario.Reinterpretation.EvEff.Logging

newtype Zooit e ans = Zooit { listScenariosOp :: Op () [String] e ans }


listScenarios :: Zooit :? e => Eff e [String]
listScenarios = perform listScenariosOp ()


toLoggedHTTP :: (HTTP :? e, Logging :? e) => Eff (Zooit :* e) a -> Eff e a
toLoggedHTTP = handler Zooit
  { listScenariosOp = function
                        (\() -> do
                          logMsg "Fetching a list of scenarios"
                          lines <$> httpGET "/scenarios"
                        )
  }
