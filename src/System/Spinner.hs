module System.Spinner (
    withSpin
  , withSpin'
  , Spinner(..)
) where

import Control.Monad (when)
import Control.Concurrent (forkIO, threadDelay)
import Data.IORef (newIORef, readIORef, writeIORef)
import Data.Function (fix)
import System.IO (hPutStr, hFlush, stderr)

data Spinner = Plain | Shobon | Custom [String]

spinnerStrings :: Spinner -> [String]
spinnerStrings Plain       = ["/", "-", "\\", "|"]
spinnerStrings Shobon      = [ "(´･ω･`)"
                             , "( ´･ω･)"
                             , "(  ´･ω)"
                             , "(   ´･)"
                             , "(    ´)"
                             , "(`    )"
                             , "(･`   )"
                             , "(ω･`  )"
                             , "(･ω･` )"
                             ]
spinnerStrings (Custom x) = x

withSpin :: Int -> Spinner -> IO a -> IO a
withSpin duration stype f = do
    let spinner = spinnerStrings stype
    endRef <- newIORef False
    forkIO . ($ cycle spinner) . fix $ \loop (str:xs) -> do
        hPutStr stderr ("\ESC[s\ESC[1K" ++ str ++ "\ESC[0K\ESC[u")
        hFlush stderr
        threadDelay duration
        end <- readIORef endRef
        when (not end) (loop xs)
    a <- f
    writeIORef endRef True
    return a

withSpin' :: IO a -> IO a
withSpin' = withSpin 100000 Plain

-- main = withSpin' $ do
--    threadDelay 2000000
--    putStrLn "◝(*´꒳`*)◜"
