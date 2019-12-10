module Day1 where

import           Control.Arrow ((&&&))

solve :: String -> String
solve = show . (part1 &&& part2) . parseInput

part1 :: [Int] -> Int
part1 = sum . fmap fuelRequired

part2 :: [Int] -> Int
part2 = sum . fmap fullFuelRequired

fuelRequired :: Int -> Int
fuelRequired mass = mass `div` 3 - 2

fullFuelRequired :: Int -> Int
fullFuelRequired = sum . tail . takeWhile (>= 0) . iterate fuelRequired

parseInput :: String -> [Int]
parseInput = fmap read . words
