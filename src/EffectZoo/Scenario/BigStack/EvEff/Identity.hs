{-# LANGUAGE FlexibleContexts #-}
module EffectZoo.Scenario.BigStack.EvEff.Identity where

import           Control.Ev.Eff

data Identity e ans = Identity
  { noop :: !(Op () () e ans)
  }

identity :: Eff (Identity :* e) a -> Eff e a
identity = handler (Identity { noop = value () })
