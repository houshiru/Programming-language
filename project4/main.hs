{-
 - Author: Lingjing Huang, lhuang2016@my.fit.edu
 - Author: Shiru Hou, shou2015@my.fit.edu
 - Course: CSE 4250, Fall 2017
 - Project: Proj4, Decoding Text
 - Language implementation: GHCi, version 8.2.1: http://www.haskell.org/ghc/
 -}

module Main where

{- Process data
-}
main :: IO()
main = interact (unlines . processData . lines)

processData :: [String] -> [String]
processData [] = []
processData (x:xs) = otherLine xs (firstLine x)

firstLine :: String -> [String]
firstLine x = preorder (makeTree (getCombo x [] (count x))) []

otherLine :: [String] -> [String] -> [String]
otherLine x y = [decode a y | a <- x]

{- Building the Tree
-}

data BinaryTree a
  = Leaf a
  | Node a a (BinaryTree a) a (BinaryTree a)
  deriving (Eq, Ord, Show)

star :: Char -> Bool
star x 
    | x == '*' = True
    | otherwise = False

count :: String -> Int
count = foldr (\x c ->if star x then (c + 1) else c) 0

makeCombo :: String -> Int -> Int -> String
makeCombo [] _ _ = []
makeCombo (x : xs) cunt index
    | (cunt /= index) = makeCombo xs cunt (if ((head xs) =='*') then (index + 1) else index)
    | otherwise = x:(take 2 xs)

makeReplace :: String -> String -> String
makeReplace [] _ = []
makeReplace [_] _ = []
makeReplace [_, _] _ = []
makeReplace (x : y : z : xs) s
    | (x:y:z:[]) == s = ('*':xs)
    | otherwise = (x:(makeReplace (y:z:xs) s))

getCombo :: String -> [String] -> Int -> [String]
getCombo str lst cunt
    | str == "*" = lst
    | otherwise  = getCombo (makeReplace str (makeCombo str cunt 1)) ((makeCombo str cunt 1):lst) (cunt - 1)

findMatch :: [String] -> Int -> Int -> [String]
-- seprate *** list in to 2 parts, without first "***",[str] 1 0
findMatch [] _ _ = []
findMatch [_] _ _ = []
findMatch (x : xs) snum cnum
    | (head (tail x)) == '*' && (last x) == '*' 
      = if ((snum + 1) == cnum) then (x:xs) else (findMatch (xs) (snum + 2) cnum)
    | (head (tail x)) /= '*' && (last x) == '*' 
      = if ((snum + 1) == cnum) then (x:xs) else (findMatch (xs) (snum + 1) (cnum + 1))
    | (head (tail x)) == '*' && (last x) /= '*' 
      = if ((snum + 1) == cnum) then (x:xs) else (findMatch (xs) (snum + 1) (cnum + 1))
    | (head (tail x)) /= '*' && (last x) /= '*' 
      = if ((snum + 1) == cnum) then (x:xs) else (findMatch (xs) snum (cnum + 2))
findMatch (_ : _ : _) _ _ = []

makeTree :: [String] -> BinaryTree Char
-- input from getCombo 
makeTree [] = Leaf '*'
makeTree (x : xs)
    | (head (tail x)) == '*' && (last x) == '*' 
      = Node (head x) '0' (makeTree (take ((length xs) - (length (findMatch xs 1 0))) xs)) '1' (makeTree (findMatch xs 1 0))
    | (head (tail x)) == '*' && (last x) /= '*' 
      = Node (head x) '0' (makeTree xs ) '1' (Leaf (last x))
    | (head (tail x)) /= '*' && (last x) == '*' 
      = Node (head x) '0' (Leaf (head (tail x))) '1' (makeTree xs)
    | otherwise = Node (head x) '0' (Leaf (head (tail x))) '1' (Leaf (last x))

{-Tree traversal
-}

preorder :: BinaryTree Char -> [Char] -> [String]
preorder (Leaf a) lst = (reverse (a : lst)) : []
preorder (Node _ lVal left rVal right) lst = (preorder left (lVal : lst)) ++ (preorder right (rVal : lst))

{- Decoding
-}

decode :: String -> [String] -> String
decode [] _ = []
decode  str code = head [ ((last e) : (decode (drop (length (init e)) str) code) ) | e <- code,
 ((take (length (init e)) str) == (init e))]
