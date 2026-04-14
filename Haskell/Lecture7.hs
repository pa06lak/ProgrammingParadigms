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
-- In maths function composition is written as f(g(x)) or f . g. 
-- Haskell uses the dot notation f g x to mean the same thing
(.) :: (b -> c) -> (a -> b) -> a -> c
f . g = \x -> f (g x)
-- Point free style means defining a function without explicitly mentioning its arguments
-- Instead of writing odd a = not (even a) we can write odd = not . even. 
-- The name point free comes from the idea that a is a point in the space, and we don't need to refer to it
-- The style removes the need for lambda expressions and can make code more readable at high level of abstraction

-- Containers you can map over
-- A list is essentially a container that holds several elements of the same type 
-- and map lets you reach inside and apply a function to each element without changing the structure of the container itself
-- But lists arent the only containers that can be mapped over wihtout changing the structure of the container
-- Binary trees, optional values and many other data structures share this same property

-- Comparing map for Lists vs Trees
-- Consider the types of a map function for lists and a bmap function for binary trees
data [] a = [] | a : [a]
map :: (a -> b) -> [a] -> [b]
data BinaryTree a = Leaf a | Node a (BinaryTree a) (BinaryTree a)
bmap :: (a -> b) -> BinaryTree a -> BinaryTree b
-- The type of map is map :: (a -> b) -> [a] -> [b] and the type of bmap is bmap :: (a -> b) -> BinaryTree a -> BinaryTree b
-- This means that both functions take a function of type a -> b and a container of type [a] or BinaryTree a and return a container of type [b] or BinaryTree b
-- The only difference is the name of the container type. This strongly suggests we should create a type class that captures this pattern. 
-- Haskell calls this type class Functor

-- The Functor Type Class
class Functor f where
fmap :: (a -> b) -> f a -> f b
-- The functor type class captures the idea of a mappable container. 
-- If a type implements the Functor interface, it defines a data structure whose elements can be transformed in a systematic way using fmap
-- fmap is the generalisation of map. 
-- It takes a function from a to b, a functor containing values of type a and returns a value of type b
-- The minimal complete definition for the Functor class is just fmap - thats all you need to provide
-- Be careful with the notation: f in the class declaration is the functor type (like List or BinaryTree), not the function you apply
-- The function argument to fmap is a separate thing. 
-- For lists fmap and map are completely synonymous - fmap (+1) [11,22,33] gives [12,23,34] exactly as map would 

-- Functor Laws
-- The minimal complete definition for the Functor class is just fmap - thats all you need to provide
-- The only constraint on the implementation of fmap is that it must apply the function to all elements of the container
-- Law 1: Identity fmap id c == c -- Mapping the identity function over a structure returns the structure unchanged
-- Law 2: Composition fmap f (fmap g c) == fmap (f . g) c -- Mapping the composition of two functions over a structure is the same as mapping the first function and then mapping the second
-- There is composition law for example 
-- Starting wiht the list [11,22,33], let g = (+1) and f = (*2)
-- One pass approach: Apply f . g (ie (\x -> (x+1)*2)) component size [24, 46, 68]
-- Two pass approach: Apply f to [11,22,33] component size [22, 44, 66] then apply g to [22, 44, 66] component size [23, 45, 67]
-- The two approaches give the same result
-- The identity law is simplier: applying id to every element of [11,22,33] should give back [11,22,33]

-- Writing functor instance Declarations
-- To make a type an intance of Functor, you provide an implementation of fmap that follows the types constructors recursively
-- Example 1: Custom List type
data List a = Nil | Cons a (List a)
deriving (Eq, Show)
instance Functor List where
fmap f Nil = Nil
fmap f (Cons a as) = Cons (f a) (fmap f as)
-- The definition follows the constructors: if the list is Nil (empty), return Nil. 
-- Otherwise, apply f to the head and recursively fmap over the tail. The lecturer notes that unlike the earlier map definition which used list comprehension, here we use explicit recursion on the constructors because we dont have list comprehension synatx for custom types

-- Example 2: Custom Binary Tree type
data Tree a = Leaf a | Node (Tree a) (Tree a)
deriving (Eq, Show)
instance Functor Tree where
fmap f (Leaf a) = Leaf (f a)
fmap f (Node a l r) = Node (f a)(fmap f l) (fmap f r)
-- Notice that the recursive structure of the binary tree is preserved
-- This follows the constructors for a Leaf, apply f to the value.
-- For a Node, apply f to the nodes's value and recurively fmap over both left and right subtrees

-- Writing Generic Code with Functors
-- Once you have Functor Instances you can write functions that work on any functor, not just lists or trees specifically
-- Works on ANY Functor containing numeric values
add1 :: (Functor c, Num a) => c a -> c a
add1 = fmap (+1)
-- Prelude> add1 (Cons1 (Cons2 (Cons 4 Nil)))
-- Cons 2(Cons 3 (Cons 5 Nil))
-- Prelude> add1 (Node 1 (Lead 2) (Leaf 4))
-- Node 2 (Leaf 3) (Leaf 5 )

-- Not every Parameterised Type is a Functor
-- It might seem like any type that types a type parameter could be a Functor, but thats not the case
-- Functor laws must hold and not every definition of fmap satifies them
-- A type describing functions from a type to itself
data Fun a = MakeFunction (a -> a)
instance Functor Fun where
fmap f (MakeFunction g) = MakeFunction id
-- This is not a functor because the identity law does not hold
-- Applying fmap id should give back the same thing, but here it always returns MakeFunction id regardless of the original function

-- Uniqueness of Function Instances
-- If you can confirm that a function law hold for your implementation of fmap, then your implementation is the only correct one
-- The laws essentially prescribe what fmap must do - it must follow the types constructors in the natural way

-- Proving the Functor Laws by Induction
-- Since fmap is defined recursively, we can prove the laws by induction using structural induction
-- Here is the proof that the identity law holds for our custom List type
-- Goal : show fmap id xs == xs for all xs
-- Base Case: xs = Nil, so fmap id xs = id Nil = Nil == xs
-- Inductive Case: xs = Cons x xs', so fmap id xs = id (Cons x xs') = Cons x (fmap id xs') == Cons x xs'
-- This shows that the identity law holds for our custom List type

-- Here is the proof that the composition law holds for our custom List type
-- Goal : show fmap (f . g) xs == fmap f . fmap g xs
-- Base Case: xs = Nil, so fmap (f . g) xs = id Nil = Nil == fmap f . fmap g xs
-- Inductive Case: xs = Cons x xs', so fmap (f . g) xs = id (Cons x xs') = Cons x (fmap (f . g) xs') == Cons x (fmap f . fmap g xs')
-- This shows that the composition law holds for our custom List type

