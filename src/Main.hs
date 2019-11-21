{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Main where
import Web.Scotty

import Data.Monoid (mconcat)

main = scotty 5000 $
    get "/:number" $ do
        number <- param "number"
        json $ fizzBuzz number

fizzBuzzOne :: Int -> String
fizzBuzzOne i | i `mod` 3 == 0 && i `mod` 5 == 0 = "Fizz"
fizzBuzzOne i | i `mod` 3 == 0 = "Fizz"
fizzBuzzOne i | i `mod` 5 == 0 = "Buzz"
fizzBuzzOne i = show i

fizzBuzz :: [Int] -> [String]
fizzBuzz [] = []
fizzBuzz (x:xs) = fizzBuzzOne x : fizzBuzz xs