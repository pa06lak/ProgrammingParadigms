-- Functors

-- The idea of this is to take operations we already know for lists like map and generalise them so they work on ay suitable container type 
-- whether this is a list, binary tree or someone defined. 
-- A functor is a data type that supports a map operation. 
-- The first and most heneral of these type classes is the Functor

-- Higher Order Functions
-- A higher order function is a function that does at least one of 
-- (1) takes one or more functions as arguments 
-- (2) returns a function as its result
-- Thanks to currying every function of more than one argument in Haskell is technically high order
-- When you partially apply a curried function you get back another function
-- For example add 1 returns a function that adds 1 to its argument
add :: Num a => a -> a -> a
add x y = x + y

-- The map function applies a given function element-wise to every element in a list
-- It is the key function we will generalise in this lecture
map :: (a -> b) -> [a] -> [b]
map _ [] = []
map f xs = [f x | x <- xs]
-- Notice how map is maximally general, the function f can transform elements from type a to a completely different type b
-- For example, map even [11,22,33] produce [False, True, False] - the input is a list of numbers but the output is a list of Boolean
-- Map does not care about the input/output types being the same - f could equally well return Booleans

-- Filter - Selecting Elements by a Predicate
filter :: (a -> Bool) -> [a] -> [a]
filter _ [] = []
filter f xs = [x | x <- xs, f x]
-- filter takes a predicate (a function that returns a Boolean) and a list and returns a list of all elements in the list that satisfy the predicate
-- This is essentially a guard mechanism in list comprehensions
-- There are many more higher order list functions in the Prelude (eg: any, all, foldr, takeWhile, dropWhile)

-- Function Composition
-- 