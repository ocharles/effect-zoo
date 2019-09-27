[Effect Zoo: A Subjective and Objective Analysis of Haskell Effect Frameworks](https://www.notion.so/09a6d3c82d24429ebe1fc99bc393bc7f)

I'm happy to announce a new little project I've been chipping away at for the last few days - `effect-zoo`. Like WHO's fantastic frp-zoo, this project aims to demonstrate effect systems through a variety of scenarios to allow users to understand their strengths and weaknesses, both in raw performance (as benchmarked by criterion) and more subjective measures like ease of use by manual code review.

In this initial release, the following frameworks are considered:

- `mtl` (or more, the idea of monad transformers and type classes).
- `fused-effects`
- `freer-simple`
- `simple-effects`
- `rio` (though not strictly an effect framework, it is often used with type classes into a shared environment).
- A "reference" implementation for each scenario - either a pure computation, or a computation in just the `IO` monad. This demonstrates solutions without effect frameworks at all.

In terms of scenarios, I've added the following so far:

- `CountDown` is a stateful computation that counts down from a seed value by decrementing one repeatedly until the state value is ≤ 0. This scenario considers speed when writing pure computations with only a single effect.
- `FileSizes` is a fairly typical effectful program that someone may want to write. The scenario requires defining separate `File` and `Logging` effects - the `File` effect allows measuring the size of a file (catching exceptions) while the `Logging` effect allows logging arbitrary strings. The program is to measure the total size of a list of `FilePath`s, logging each file considered. This scenario demonstrates how easy it is to define and use custom effects, and the performance of effect frameworks in code that is dominated by IO speed.
- `Polymorphic` uses what I call polymorphic effects - effects that themselves are parameterized. In this scenario we just write a stateful program that
- `BigStack` explores how effect frameworks deal as the number of effects increases. The program uses a reader effect to read a number - *n* - of iterations. After this, a state computation is ran *n* times, incrementing the state. When we run this program the reader and state effects are separated by an arbitrary number of other unused effects. This scenario aims to explore how effect frameworks deal with large amounts of effects in one program.
- `HigherOrder` looks at implementing an exception masking effect. This effect has a signature that is not supported by all frameworks, as the effect takes a monadic argument.
- `Reinterpretation` looks at reinterpreting an effect in terms of one or more primitive effects. Specifically, we look at a program that does a series of API calls the zooit using a special zooit effect. This effect is then reinterpreted into logging and HTTP effects, which are finally eliminated with a writer effect and reader effect (mocking all HTTP calls with a static response).
- `Inline`/`NoInline` both look at the effect of GHC's optimizer on effectful programs. The program itself is the same reader/state program from `BigStack`, but reader and state effects are redefined with everything marked as `{-# INLINE #-}` or `{-# NOINLINE #-}`, respectively. The program itself is also marked as `{-# INLINE #-}`.

The results can be found here. For each scenario I've included graphs showing the distribution of timings, along with some code metrics. All benchmarks are ran on a fresh Packet `t1.small.x86` instance, running NixOS 18.09 and Linux xyz. This is a bare metal machine running nothing else to try and remove any benchmarking noise. To allow the code to be comparable, all Program modules are written to be as identical as possible, and all code is formatted with `hindent` for consistency.

This work is not finished - if the zoo doesn't have what you're looking for, please consider contributing! If you feel a common scenario isn't repainted, please open an issue and we can discuss what a good example scenario would look like. Likewise, if you feel an effect framework isn't being correctly represented (or your favourite framework is missing), contributions to existing scenarios are always welcome.
