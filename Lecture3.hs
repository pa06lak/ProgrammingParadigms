-- Recursion

-- Work through the standard library function drop which removes the first n elements from a list 
-- Step 1: Define the type signature
drop :: Int -> [a] -> [a]
-- Step 2: Enumerate the cases (consider all the combinations of base cases for each argument)
-- So an integer can be 0 or non zero; the list can be empty or non empty
--drop 0 [] = ???
--drop 0 (x:xs) = ???
--drop n [] = ???
--drop n (x:xs) = ???
-- Step 3: Define the vase cases
drop 0 [] = [] -- drop nothing from nothing 
drop 0 (x:xs) = x:xs -- drop nothing so keep everything 
drop n [] = [] -- drop something from nothing, still nothing
-- Step 4: Define the recursive case
drop n (x:xs) = drop (n-1) xs -- drop one from
-- Step 5: Generalise and simplify
drop :: Int -> [a] -> [a]
drop 0 xs = xs
drop _ [] = []
drop n (x:xs) = drop (n-1) xs

-- Linear Recursion: The recursive call contains only a single self reference
length' [] = 0 -- The length of an empty list is 0
length' (x:xs) = 1 + length' xs -- The length of a non-empty list is 1 plus the length of the tail of the list

-- Multiple Recursion: The recursive call contains multiple self-references
fib 0 = 0 -- The 0th Fibonacci number is 0
fib 1 = 1 -- The 1st Fibonacci number is 1
fib n = fib (n-1) + fib (n-2) -- The nth Fibonacci number is the sum of the (n-1)th and (n-2)th

-- Direct recursion: The function calls itself directly
product' [] = 1 -- The product of an empty list is 1
product' (x:xs) = x * product' xs -- The product of a non

-- Mutual Recursion: Two or more functions call each other
even' :: Integral a => a -> Bool -- Define the function here with a lambda function and the Integral 
even' 0 = True -- 0 is even 
even' n = odd' (n-1) -- A number is even if the number one less than it is odd

odd' :: Integral a => a -> Bool -- Define the function here with a lambda function and the Integral
odd' 0 = False -- 0 is not odd
odd' n = even' (n-1) -- A number is odd if the number one less than it is even

-- Tail Recursion: The recursive call is the last operation performed in the function
product' xs = loop xs 1 -- Define a helper function loop that takes the list and an accumulator
  where
    loop [] acc = acc -- If the list is empty, return the accumulated product
    loop (x:xs) acc = loop xs (acc * x) -- Multiply the head of the list with the accumulator and recurse on the tail

-- The ways to reverse
reverse' [] = [] -- The reverse of an empty list is an empty list
reverse' (x:xs) = reverse' xs ++ [x] -- The reverse of a non-empty list is the reverse of the tail of the list concatenated with the head of the
-- This is a much more efficient way to reverse a list because it avoids the use of the (++) operator which is O(n) in the length of the first argument
reverse' xs = reverse '' xs []
reverse'' [] ys = ys -- The reverse of an empty list is the accumulator
reverse'' (x:xs) ys = reverse '' xs (x:ys) -- The reverse of a non-empty list is the reverse of the tail of the list with the head of the list added to the accumulator


