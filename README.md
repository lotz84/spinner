spinner
=======

Inspired by [morishin/spinner](https://github.com/morishin/spinner)

```haskell
import Control.Concurrent (threadDelay)
import System.Spinner

main = withSpin' $ do
    threadDelay 2000000
    putStrLn "◝(*´꒳`*)◜"

```

![](demo.gif)


If you want to use this library with stack, add to `stack.yaml` this repo location as below.

```yaml
packages:
- location:
    git: git@github.com:lotz84/spinner.git
    commit: d39db825756e837c8bb0f1e8197eae6f1f0efe88
```

##LICENSE
BSD3
