module Logic
( getCoords
) where

import qualified Data.List as L

getCoords :: [Float] -> [(Float, Float)]
getCoords numbs = getCoords' (small (big numbs 1) 1) (length numbs) 0

getCoords' :: [Float] -> Int -> Int -> [(Float, Float)]
getCoords' [] _ _     = []
getCoords' (x:xs) l n = (tupleMap round' ((x*(cos angle)) + 250, (x*(sin angle)) + 250)) : getCoords' xs l (n + 1)
                        where angle = ((2*pi)/fromIntegral(l)) * fromIntegral(n) 

round' :: Float -> Float
round' x = (fromInteger(round (x * 10000))) / 10000

tupleMap :: (a -> b) -> (a, a) -> (b, b)
tupleMap f (a1, a2) = (f a1, f a2)

big :: [Float] -> Float -> [Float]
big [] _ = []
big c n  = case L.find (> 248) (map (/n) c) of Just x -> big c (n+0.5)
                                               Nothing -> map (/n) c

small :: [Float] -> Float -> [Float]
small [] _ = []
small c n = case L.find (> (248/n)) c of Just x -> map (*(n-0.5)) c
                                         Nothing -> small c (n+0.5)