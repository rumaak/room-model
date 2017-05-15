{-# LANGUAGE OverloadedStrings #-}
module Main where

import Web.Scotty as W
import Network.Wai.Parse
import Logic

import qualified Data.Text.Lazy as TL
import qualified Data.Text.Lazy.Read as RE
import qualified Data.Text.Lazy.Encoding as EN
import qualified Data.ByteString.Lazy as BS

import Text.Blaze.Svg11 hiding (title) 
import Text.Blaze.Svg11.Attributes as A hiding (title) 

import Text.Blaze 
import qualified Text.Blaze.Html5 as H
import Text.Blaze.Html5.Attributes
import Text.Blaze.Html.Renderer.Text (renderHtml)

import Text.Read 

main :: IO ()
main = scotty 80 $ do 

	W.get "/" $ do
	  	setHeader "Content-Type" "text/html"
	  	file "./html/page.html"

  	post "/" $ do 
  		spins <- (param "spins") `rescue` (\msg -> next)
  		input <- files
  		html $ renderHtml 
  		     $ H.html $ do
  		     	H.body $ do
  		     		H.p "Result:"
  		     		procc input spins		

  	post "/" $ do 
  		html $ renderHtml 
  		     $ H.html $ do
  		     	H.body $ do
  		     		H.p "Missing number of spins!"

procc :: [W.File] -> Float -> Svg
procc input spin = svgPic . textValue . TL.toStrict . toText . getCoords (handle . makeNumbs . fromFile $ input) $ spin

fromFile :: [W.File] -> [TL.Text]
fromFile input = TL.lines (EN.decodeUtf8 (fileContent (snd (head input))))

makeNumbs :: [TL.Text] -> [Maybe Float]
makeNumbs [] = []
makeNumbs (x:xs) =  readMaybe (TL.unpack x) : makeNumbs xs

svgPic :: AttributeValue -> Svg
svgPic coords = svg ! A.width "500" ! A.height "500" $ do
            polygon ! points coords ! stroke "black"
                    ! strokeWidth "2" ! fill "green" 
            circle ! cx "250" ! cy "250" ! r "5" 
                   ! stroke "black" ! strokeWidth "2"
                   ! fill "blue"

toText :: [(Float, Float)] -> TL.Text
toText []         = ""
toText ((a,b):xs) = TL.append (TL.append (TL.pack $ show a) (TL.append "," (TL.append (TL.pack $ show b) " "))) (toText xs)

handle :: [Maybe a] -> [a]
handle [] = []
handle (x:xs) = case x of Just x  -> x : handle xs
                          Nothing -> handle xs
