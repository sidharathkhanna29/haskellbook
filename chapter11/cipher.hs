
import Data.Char (chr, ord, isAsciiUpper, isAsciiLower)

rotateLetter :: Char -> Int -> Char
rotateLetter c r
  | isAsciiLower c = shift (ord 'a')
  | isAsciiUpper c = shift (ord 'A')
  | otherwise      = c
  where shift base = chr (base + (((ord c) - base + r) `mod` len))
        len        = 1 + (ord 'z') - (ord 'a')

rotate :: String -> [Int] -> String
rotate []     _      = []
rotate xs     []     = xs
rotate (x:xs) (r:rs) = rotateLetter x r : rotate xs rs

rotation :: [Char] -> [Int]
rotation []        = []
rotation (k:ks)
  | isAsciiLower k = (ord k - ord 'a') : rotation ks
  | isAsciiUpper k = (ord k - ord 'A') : rotation ks
  | otherwise      = rotation ks

encrypt :: String -> String -> String
encrypt [] _  = []
encrypt xs [] = xs
encrypt xs ks = rotate xs (concat (repeat (rotation ks)))

decrypt :: String -> String -> String
decrypt [] _  = []
decrypt xs [] = xs
decrypt xs ks = rotate xs (concat (repeat (map negate (rotation ks))))

--

text = "Hello, my friend! How are you? Goodbye."
key  = "A$ bHt6 :; {v%)H*..Jq@3xc1 |"

works = text == decrypt (encrypt text key) key
