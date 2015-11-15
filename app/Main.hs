module Main where

import Control.Concurrent (threadDelay)
import System.Spinner

main = withSpin' $ do
    threadDelay 2000000
    putStrLn "◝(*´꒳`*)◜"
