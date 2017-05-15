## Room model
This is a REALLY simple web made in Haskell with help of Scotty API. 

## Features
The website runs on port 80, acces is similar to Apache. Displayed page let's you input .txt file. If it contains numbers in certain format, svg picture will be shown after sending.

## Goal
The main purpose of this project for me was getting a bit more to Haskell in more practical way and to learn to work with some Haskell API's. 

## Test yourself
The project was made for output from Arduino robot, that should spin in the middle of a room. It should also capture distances by a ultrasonic sensor and then write them to a file. On the web page itself, you also have to write how many times it made a full round (number of spins). Unfortunately, the code and specifications for Arduino aren't yet available. The .txt file should contain any number of numbers separated only by newline (simply Enter). Example room-model-example is included in root directory.

