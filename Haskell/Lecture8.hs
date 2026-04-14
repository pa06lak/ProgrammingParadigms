-- Applicatives

-- Now what if the function takes two arguments or three or more

-- Generalising fmap
-- Recall that fmap (from the Functor Class) maps a single argument function over a container
-- We'd like a whole heirarchy of map-like functions

-- fmap0 :: a -> f a
-- fmap1 :: (a -> b) -> f a -> f b
--- fmap2 :: (a -> b -> c) -> f a -> f b -> f c
-- fmap3 :: (a -> b -> c -> d) -> f a -> f b -> f c -> f d
-- ...
-- fmap is the degenerate case where the function is just a constant value being liften into the container
-- fmap1 is exactly fmap from Functor. fmap2 handles two-arguments functions, and so on 
-- The key insight is that we dont need a separate function for each arity - currying lets us build them all from just two operations

-- Two core operations: Pure and <*>
-- An applicayive (applicative functor) extneds Functor with two additional operations
-- pure lifts a plain value into the functor and <*> applies a function in the functor to a value in the functor
-- pure :: a -> f a
-- <*> :: f (a -> b) -> f a -> f b

-- What pure does
-- pure takes a plain value and wraps it into the functor structure. For lists pure x = [x] 
-- It creates a single element list 
-- The lecturer explained pure converts a value of type a into a functor of that same type. For our canonical list example, it takes a function and makes a list containing just that function

-- What <*> does
-- <*> takes a function in the functor and applies it to a value in the functor
-- This is a generalised form a function application where both the function and its argument are wrapped in functor structures
-- It takes a functor containing functions and a functor containing values, and applies each function to each value.

-- Application Style
-- A typical use chains these operations together. This pattern is called applicative style
-- pure g <*> x1 <*> x2 <*> x3 ... <*> xn
-- Here g is a function of a arguments, and x1 through xn are functors. 
-- You start by lifting g into the functor with pure, then repeatedly use <*> to feed in each argument
-- The lecturer stresses that this is all we need to handle any number of inputs
-- Because of currying, when you apply pure g <*> x1 you get back a functor of partially applied functions, which you can then apply to the next argument with another <*>

-- How currying makes it all work
-- The generalised fmap functions are all defined in terms of pure and <*>
-- fmap :: a f a 
-- fmap0 = pure
-- fmap1 :: (a -> b) -> f a -> f b
-- fmap1 g x = pure g <*> x
-- fmap2 :: (a -> b -> c) -> f a -> f b -> f c
-- fmap2 g x1 y = pure g <*> x1 <*> y
-- fmap3 :: (a -> b -> c -> d) -> f a -> f b -> f c -> f d
-- fmap3 g x1 y z = pure g <*> x1 <*> y <*> z
-- This magic is currying pure g <*> x doesnt fully apply g if it takes multiple arguments 
-- it returns a functor of partially applied functions
-- Each subsequent <*> feeds in one more argumnet

-- Applicative Type Class
-- class Applicative f where
-- pure :: a -> f a
-- <*> :: f (a -> b) -> f a -> f b
-- Applicative is a subclass of Functor - any type that is applicative must also be a functor
-- This makes sense: if you can apply multi-argument functions, (<*>) you can certainly apply single argument functions (fmap)
-- The minimal complete definition requires both pure and <*>

-- The applicative laws
-- Applicative instances must satisfy four laws
-- Identity
-- pure id <*> v = v
-- Composition
-- pure (.) <*> u <*> v <*> w = u <*> (v <*> w)
-- Homomorphism
-- pure f <*> pure x = pure (f x)
-- Interchange
-- u <*> pure y = pure ($ y) <*> u
-- The key takeaway is that laws guarantuee you can always rearrange expressions into applicative style
-- pure at the far left, no brackets needed. 
-- If pure appears somewhere other than at the start, the laws let you push it to the left

-- List an applicative - The Main Example 
-- The Instance Declaration
instance Applicative [] where
    -- pure :: a -> [a]
    pure x = [x]
    -- (<*>) :: [a -> b] -> [a] -> [b]
    fs <*> xs = [f x | f <- fs, x <- xs]
-- Pure wraps a value in a single element list. 
-- (<*>) applies a function in the list to a value in the list and returns a list of results
-- It computes all possible combinations using a list comprehension

-- Worked Example 1: Single Argument Function 
-- Step 1: pure (+1) creates [\y -> y + 1] — a list containing one function.
-- Step 2: [\y -> y+1] <*> [1,2,3] applies that function to each element: substitute
--y=1 to get 2, y=2 to get 3, y=3 to get 4.
--Result: [2, 3, 4]

-- Worked Example 2: Multiple Argument Function 
-- Step 1: (+) is \x -> \y -> x+y. So pure (+) = [\x -> \y -> x+y].
-- Step 2: [\x -> \y -> x+y] <*> [1,2,3] substitutes x with each value:
-- x=1: \y -> 1+y
-- x=2: \y -> 2+y
-- x=3: \y -> 3+y
-- Result so far: [\y->1+y, \y->2+y, \y->3+y] — a list of partially applied functions!
-- Step 3: Apply this list of functions to [44, 55]. Each function is applied to each value:
-- (\y->1+y) applied to 44 = 45, then to 55 = 56
-- (\y->2+y) applied to 44 = 46, then to 55 = 57
-- (\y->3+y) applied to 44 = 47, then to 55 = 58


-- The rest of the information is in the pdf

