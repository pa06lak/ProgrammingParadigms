import Exercise2 (x1)
-- Types

-- Int -> Bound precision integer (fixed size, typically 32 or 64 bits )
-- Integer -> Unbounded precision integer (arbitrary size, limited only by available memory and no overflow)
-- Float -> Single precision floating point number (32 bits, approximately 7 decimal digits of precision)
-- Double -> Double precision floating point number (64 bits, approximately 15 decimal digits of precision)
-- Bool -> Boolean type (True or False)
-- Char -> Character type (represents a single Unicode character) 
-- [a] -> List of elements of type a (e.g., [Int] is a list of integers, [Char] is a string)
-- (a, b) -> Tuple containing two elements of types a and b (e.g., (Int, String) is a tuple containing an integer and a string)
-- Maybe a -> A type that can either be Nothing (representing the absence of a value) or Just a (representing the presence of a value of type a)
-- Either a b -> A type that can either be Left a (representing an error or failure case with a value of type a) or Right b (representing a success case with a value of type b)
-- IO a -> A type representing an input/output action that produces a value of type a (used for side effects in Haskell)

-- So when we compute the factorial of 1000000, we use Integer rather than Int otherwise we would overflow
-- For boolean conjuction is && and disjunction is ||, and for negation is not

-- If often makes sense to define our own types using the data keyword. For example, we can define a binary tree data structure as follows:
data Tree a = Empty | Node a (Tree a) (Tree a) deriving (Show, Eq)
-- This defines a parametric type Tree that can hold values of any type a. The Tree type has two constructors: Empty, which represents an empty tree, and Node, which represents
--a node in the tree that contains a value of type a and two subtrees (the left and right children). The deriving (Show, Eq) part automatically generates instances of the Show and Eq type classes for the Tree type, allowing us to print trees and compare them for equality.
-- This allows for you to hide complexity, build new abstractions, create more complex data structures and type safety 

-- Haskell provides three mechanisms for defining new types:
-- 1. type - used for creating type synonyms, which are alternative names for existing types. For example, type String = [Char] creates a type synonym for lists of characters, allowing us to use String instead of [Char] in our code. This is not recursive
-- 2. data - creates a completely new type with constructors that can be used to create values of that type. For example, data Maybe a = Nothing | Just a defines a new type Maybe that can either be Nothing or Just a value of type a. This is recursive
-- 3. newtype - creates a new type that is a wrapper around an existing type. For example, newtype Age = Age Int defines a new type Age that wraps an Int. This is useful for creating distinct types that have the same underlying representation, allowing for type safety without the overhead of a full data type. This is not recursive
-- The focus is type nad data in this course

-- A type declaration creates a synonym - a new name for a type that already exists. 
-- objects of the synonym type and the original type are completely interchangeable. It adds no type distinction, it is purely for readability and documentation
type String = [Char] -- This creates a type synonym for lists of characters, allowing us to use String instead of [Char] in our code. This is not recursive
-- From this point on String and [Char] are completely interchangeable. You can freely pass one where the other is expected
vowels :: String -> [Char] -- This defines a function vowels that takes a String (which is a list of characters) and returns a list of characters (the vowels in the string)
vowels str = [s | s <- str, s `elem` "aeiouAEIOU"] -- This uses a list comprehension to iterate over each character s in the input string str and checks if it is a vowel (i.e., if it is an element of the string "aeiouAEIOU"). If it is a vowel, it is included in the resulting list of characters.
-- This function will return a list of all the vowels in the input string, preserving their case
-- Instead of working with raw tuples we give them a meaningful name - making code more readable with Pos
type Pos = (Int, Int) -- This creates a type synonym for a tuple of two integers, representing a position in a 2D grid. This is not recursive
origin :: Pos -- This defines a value origin of type Pos, which is a tuple representing the coordinates (0, 0) in a 2D grid.
origin = (0, 0) -- This assigns the value (0, 0)
-- We can also define a function to move a position by a given delta
left :: Pos -> Pos
left (x, y) = (x - 1, y) -- This defines a function left that takes a Pos (a tuple of two integers representing a position) and returns a new Pos that is one unit to the left of the original position by subtracting 1 from the x-coordinate while keeping the y-coordinate unchanged.
right :: Pos -> Pos
right (x, y) = (x + 1, y) -- This defines a function right that takes a Pos (a tuple of two integers representing a position) and returns a new
-- Type declarations can take type variables as parameters, just like function definitions
type Pair a = (a, a) -- This creates a type synonym for a tuple containing two elements of the same type a. This is not recursive
-- This allows us to create pairs of any type, such as Pair Int for pairs of integers, Pair String for pairs of strings, etc. For example:
mult :: Pair Int -> Int -- This defines a function mult that takes a Pair of Int (a tuple containing two integers) and returns an Int (the product of the two integers).
mult (x, y) = x * y -- This implements the mult function by pattern matching on the input tuple (x, y) and returning the product of x and y. For example, mult (3, 4) would return 12. This function can be used with any
dup :: a -> Pair a -- This defines a function dup that takes a value of any type a and returns a Pair of that type (a tuple containing two copies of the input value).
dup x = (x, x) -- This implements the dup function by taking an input value x and returning a tuple (x, x) that contains two copies of x. For example,
-- dup 5 would return (5, 5), and dup "hello" would return ("hello", "hello"). This function can be used with any type a, making it a generic function that works for all types.
-- Haskell encourages you to be as general as possible. Notice that dup works for any type a not just Int. 
-- This is a key design philosophy of Haskell, write the most general type signature your function actually needs

-- a data keyword lets you create completely new types by specifying their allowed values (constructors)
-- This is the most powerful and commonly used mechanism
-- a data declaration introuduces a new type by lising its constructors - the wau to build values of that type. 
-- Both the type name and constructor names must start with an uppercase
data Bool = False | True -- Bool (as defined in the Prelude). 
-- This says "Bool is a new type with two constructors False and True" The pipe | means or a value of type Bool is either False or True
data IsTrue = Yes | No | Perhaps
negate :: IsTrue -> IsTrue
negate Yes = No
negate No = Yes
negate Perhaps = Perhaps

-- Constructors font have to be simple constants - they can be functions that take parameters
data Shape = Circle Float | Rectangle Float Float 
area :: Shape -> Float
area (Circle r) = pi * r^2
area (Rectangle x y) = x * y
-- Here Circle is a constructor that takes one Float (radius) and Rectangle takes two floats (wwidth and height)
-- We pattern match on the constructors to define areas for each case
-- You can think of constructors as labelled containers for data

-- Data declarations can be polymorphic by using type variables. This one of Haskells great strengths
-- You define a structure once and it works for any type
-- The maybe type
data Maybe a = Nothing | Just a
-- Maybe encapsulates the idea of an operation that might fail. 
-- If it fails then you get nothing
-- If it suceeds with a value x, you get Just x. 
-- This is a haskell safe alternative to null pointers to exceptions

-- Safe head of a list
safehead :: [a] -> Maybe a
safehead [] = Nothing
safehead (x:_) = Just x
-- Haskell encourages generality even if you have Int in the mind right now 
-- writing your types with type variable measn when you want to do the same thing with Bools or Chars, its next done

-- Recursive Types
-- Unlike type synonyms, data declarations can be recursive - a type can refer to itself in its own definition. 
-- This lets us define powerful data structures like trees and graphs
data Nat = Zero | Succ Nat
-- This defines a type Nat that can be either Zero or Succ of another Nat using Peano axioms. 
-- Zero represents 0, Succ Zero represents 1, Succ (Succ Zero) represents 2, etc.
-- This is a great way to define recursive data structures
add :: Nat -> Nat -> Nat
add Zero n = n
add (Succ m) n = Succ (add m n)
-- This defines a function add that takes two Nats and returns a Nat. 
-- It uses the Peano axioms to define addition.
-- Linked Lists
data List a = Empty | Cons a (List a)
-- This defines a type List that can be either Empty or Cons of a value of type a and a List of the same type
-- This mirrors Haskells build in list type. The constructor Cons corresponds to the (:) operator in Haskells list type
-- For example
intList = Cons 1 (Cons 2 (Cons 3 Empty)) -- = [1, 2, 3 ]
-- Haskells build in list type is essentially defined as data [] a = [] | a : [a]
-- Binary Trees
data Tree a = Empty | Node a (Tree a) (Tree a)
-- This defines a type Tree that can be either Empty or Node of a value of type a and two subtrees (the left and right children).
-- This mirrors Haskells build in tree type. The constructor Node corresponds to the (:) operator in Haskells tree type
-- For example
tree = Node "a" (Node "b" Empty Empty) (Node "c" Empty Empty)
-- Haskells build in tree type is essentially defined as data Tree a = Empty | Node a (Tree a) (Tree a)
-- You always have to to go all the way down to empty - every leaf must terminate with the base case of the recursion

-- Pattern Matching on Custom Types
-- The same matching we use with built-in lists works identically with custom data types. 
-- You match on the constructors of your type
data List a = Empty | Cons a (List a)
list = Cons 1 (Cons 2 (Cons 3 Empty))
(Cons tip rest) = list -- tip = 1, rest = Cons 2 (Cons 3 Empty)

-- newtype (briefly explain )
-- This is not tested for the exam 
-- newtype is a restricted version of data, it only allows a single constructor with a single field
-- The constructor is erased at compile time, giving a slight performance optimisation
newtype Rectangle = Rectangle (Int, Int) -- allowed
-- newtype Maybe a = Just a | Nothing -- NOT allowed (two constructors)
--newtype Rectangle = Rectangle Int, Int -- not allowed (two fields)

-- Haskells data declarations create what are called Algebraic Data Types (ADTs). 
-- The algebra comes from two operations
-- 1. Sum type (alternation/ or) - A value is one of several alternatives. 
-- Example: data Foo = A | B - a foo is either A or B 
-- 2. Product type (combination/ "and") - A value bundles several pieces together. 
-- Example data pair = P Int Double - a pair contains an Int and a double together
