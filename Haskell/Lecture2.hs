-- Using Lambda functions in Haskell

-- The nameless function that takes x and returns x + x
-- Since there is no lambda on the keyboard, Haskell uses a backslash to denote a lambda function
-- and instead of the dot use an arror -> 

\x -> x + x

-- Case 1: Formalising Curried Functions
-- A lambda function that takes two arguments x and y and returns x + y
add x y = x + y
-- This is the same as the function below
add = \x -> (\y -> x + y)
-- This makes it explicit that add is a curried function of one variable returning another function

-- Case 2: Returning a function as a result
const :: a -> b -> a
const x _ = x
-- This is the same as the function below
const x = \_ -> x
-- This makes it explicit that const is a curried function of one variable returning another function
-- const eats an a and returns a function that always returns that same a, no matter what

-- Case 3: Computing Length with const and map
-- The map function applies a function to every element of a list. Its type is (a -> b) -> [a] -> [b]
-- map f xs applied f to every element of the list xs and returns a new list with the results
map (+1) [1, 2, 3] -- This will return [2, 3, 4]
-- We can use const to create a function that always returns 1, and then map it
map (const 1) [1, 2, 3] -- This will return [1, 1, 1]
length' xs = sum (map (const 1) xs) -- This will return the length of the list xs by summing a list of 1s of the same length as xs
-- This is the same as the function below
length' xs = sum (map (\_ -> 1) xs) -- This will also return the length of the list xs by summing a list of 1s of the same length

-- Case 4: One off functions (Avoiding Naming)
-- Generate first n positive odd numbers
-- With a named helper
odd n = map f [1..n]
    where f x = 2*x - 1
-- With a lambda function
odd n = map (\x -> 2*x - 1) [1..n]  
odd 5 = [1, 3, 5, 7, 9] -- No need to name the function, just use it inline
-- This is more concise and avoids the need to name the helper function f, which is only
-- used once and does not need to be reused elsewhere in the code

-- Translating between named and lambda forms
f a b c = ....
-- This is the same as
f = \a -> \b -> \c -> ....
-- This is the same as
f = \a b c -> ....
-- Pattern matching works in lambdas too: 
head = \(x:_) -> x
-- This is the same as
head (x:_) = x

-- How Haskell Represents Lists
-- A list of integers [1, 2, 3] is represented as 1 : (2 : (3 : []))
-- The empty list is represented as []
-- The list [1, 2, 3] can also be represented as 1 : 2 : 3 : []
-- The list [1, 2, 3] can also be represented as 1 : (2 : (3 : [])) or 1 : 2 : 3 : []
-- Some performance consequences are that head, tail (:) are O(1) constant time
-- length, reverse, (!!) are O(n) linear time as it must traverse the linked list

-- Match a 3-element list starting with 'a'
startsWithA :: [Char] -> Bool -- Define the function here with a lambda function
startsWithA ('a':_:_:_) = True
startsWithA _ = False

-- Match ANY list starting with 'a'
startsWithA :: [Char] -> Bool -- Define the function here with a lambda function
startsWithA ('a':_) = True
startsWithA _ = False

-- Match list starting with 'a' and ending with 'b'
startsWithAB :: [Char] -> Bool -- Define the function here with a lambda function
startsWithAB ('a':'b':_) = True
startsWithAB _ = False

-- The patterns are checked in order. If you put the wildcard pattern first, it would always match and the specific pattern below would never be reached

-- Binding variables in pattern matching
-- Sum the first two elements of a list
sumTwo :: Num a => [a] -> a
sumTwo (x:y:_) = x + y
-- sumTwo [1,2,3,4] introduces the variables x and y, and returns their sum
-- x = 1, y =2, so it returns 3
-- If the list has less than 2 elements, it will not match the pattern and will
-- result in an error. We can add a catch-all pattern to handle this case
-- We cannot repeat variable names but wildcards can repeat variable names

-- Boolean conjunction via pattern matching
(&&) :: Bool -> Bool -> Bool
True && True = True
_ && _ = False
-- Head via pattern matching
head :: [a] -> a
head (x:_) = x
-- NOT ALLOWED (++ is not a data constructor):
-- last (xs ++ [x]) = x

-- Haskell can construct lists using comprehension
[ x | x <- [1..10], x `mod` 2 == 0 ]
-- This will generate a list of all x such that x is in the list [1..10] and x is even
-- This will return [2, 4, 6, 8, 10]
-- x <- [1..10] is called a generator, and x `mod` 2 == 0 is called a filter (or guard)

-- Multiple generators work like nested loops. The rightmost generator changes fast
[ (x, y) | x <- [1..3], y <- [1..3] ]
-- This will generate a list of all pairs (x, y) such that x is in [1..3] and y is in [1..3]
-- For example (1, 1), (1, 2), (1, 3), (2, 1), (2, 2), (2, 3), (3, 1), (3, 2), (3, 3)
-- Later generators can reference earlier variables 
[ (x,y) | x <- [1..3], y <- [x..3] ]
-- This will generate a list of all pairs (x, y) such that x is in [1..3] and y is in [x..3]
-- For example (1, 1), (1, 2), (1, 3), (2, 2), (2, 3), (3, 3)
-- all pairs where the second element is greater than or equal to the first element

-- Guard filter values using any function that returns a Bool. Guards can only refer to variables that have already been introduced by a generator
-- x must be even, y ranges from x to 3
[ (x,y) | x <- [1..3], even x, y <- [x..3] ]
-- This will generate a list of all pairs (x, y) such that x is in [1..3], x is even, and y is in [x..3]
-- For example (2, 2), (2, 3) because 1 and 3 are not even, so they are filtered out by the guard
-- ERROR: you can't use 'even y' before y is defined
-- This will generate an error because y is not defined before the guard 'even y' is used
[ (x,y) | x <- [1..3], even y, y <- [x..3] ]
-- This will generate an error because y is not defined before the guard 'even y' is used


