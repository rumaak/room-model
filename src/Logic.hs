module Logic
( getCoords
) where

import qualified Data.List as L

getCoords :: [Float] -> Float -> [(Float, Float)]
getCoords numbs spin = getCoords' (small (big numbs 1) 1) (length numbs) (2*pi*spin) 0

getCoords' :: [Float] -> Int -> Float -> Int -> [(Float, Float)]
getCoords' [] _ _ _     = []
getCoords' (x:xs) l a n = (tupleMap round' ((x*(cos angle)) + 250, (x*(sin angle)) + 250)) : getCoords' xs l a (n + 1) 
                        where angle = (a/fromIntegral(l)) * fromIntegral(n) 

-- Functions "big" and "small" take care of proportions of result
-- (for example coords of values 14, 20, 35, 10 are too small for
-- 500 x 500 canvas, hence they all need to be resized by same 
-- number). Second parameter of function is just arbitrary number.

big :: [Float] -> Float -> [Float]
big [] _ = []
big c n  = case L.find (> 248) (map (/n) c) of Just x -> big c (n+0.5)
                                               Nothing -> map (/n) c
small :: [Float] -> Float -> [Float]
small [] _ = []
small c n = case L.find (> (248/n)) c of Just x -> map (*(n-0.5)) c
                                         Nothing -> small c (n+0.5)

-- Custom auxiliary functions

round' :: Float -> Float
round' x = (fromInteger(round (x * 10000))) / 10000

tupleMap :: (a -> b) -> (a, a) -> (b, b)
tupleMap f (a1, a2) = (f a1, f a2)