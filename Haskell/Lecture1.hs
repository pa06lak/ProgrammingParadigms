-- Declaring a variable and its type
x :: Int
x = 3
-- This is not allowed x = 4

-- A simple function that takes an argument and returns it
-- This is called the identity function, and it can work with any type
-- This is a type signature for the function id'
id' :: a -> a
-- Here is the definition of the function id'
id' x = x

-- This means that f takes one Int and returns a function and takes another Int and returns an Int
f :: Int -> Int -> Int
-- Instead of taking two arguments at once Haskell takes one argument at a time and returns a function that takes the second argument
-- f takes an Int x and returns a function that takes another Int y and returns the result of x + 2*y
f x y = x + 2*y

-- A list of integers
xs :: [Int]
xs = [1, 2, 3, 4, 5]

-- A list of lists of integers
xss :: [[Int]]
xss = [[1, 2], [3, 4], [5, 6]]

-- Uncurried - takes a tuple (pair) as a single argument
add' :: (Int, Int) -> Int
add' (x, y) = x + y

-- Curried - takes arguments one at a time
add'' :: Int -> Int -> Int
add'' x y = x + y

add x y = x + y -- This is also a curried function, Haskell will automatically curry it


-- The main function to run the program
main :: IO ()
main = do
    print x
    print(id' 5) -- This will print 5 using out id function
    print (id' x)
    print (f 3 4)
    print(3 `f` 4)
    print xs
    print xss
    print(head xs) -- This will print the first element of the list xs
    print(tail xs) -- This will print the list xs without the first element
    print(length xs) -- This will print the length of the list xs
    print(sum xs) -- This will print the sum of the elements in the list xs
    print(map (*2) xs) -- This will print a new list where each element of xs is multiplied by 2
    print(filter even xs) -- This will print a new list
    print(init xs) -- This will print the list xs without the last element
    print(last xs) -- This will print the last element of the list xs
    print(take 3 xs) -- This will print the first 3 elements of the list xs
    print(drop 3 xs) -- This will print the list xs without the first 3
    print(add' (3, 4)) -- This will print 7 using the uncurried add function
    print(add'' 3 4) -- This will also print 7 using the curried add function
    print(add 3 4) -- This will also print 7 using the curried add function