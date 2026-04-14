-- Classes

-- Haskell is strictly typed; every expression has exactly one type known at compile timee
-- So this raises the question that if length can be applied to a list of Bools nd also a list of Ints does it need a different type for each caswe
-- But it does not because length has a single polymorphic type
length :: [a] -> Int
length [] = 0
length (x:xs) = 1 + length xs
-- Here a is a polymorphic type variable. 
-- It stands for any type whatsoever. 
-- This means length works identically regardless of what type the list elements are it never inspects the elements
-- It only cares about the list structure and this is called parametric polymorphism

-- Three kinds of Polymorphism
-- Parametric Polymorphism - Write a single implementation of a function that applied generically and identially to values of any type
-- The function cannot inspect the type parameter. This is what Haskell uses
-- Ad-hoc Polymorphism - Write different implementations of a function for different types, one for each type you wish to support
-- The correct implementatipon is selected based on the type
-- Subtype polymorphism - Relate datatypes by substitutability. Write a function for a supertype; all subtype can use it automatically
-- This is the OOP inheritance model
-- Comparision of all in code
-- Parametric Polymorphism is the default
length :: [a] -> Int
length [] = 0
length (_:xs) = 1 + length xs
-- The others arent haskell

-- When you see a lowercase letter in a type signature (like a,b), 
-- This is a type variable - a placeholder for any type and this is what makes Haskell functions generic
-- Works for any type a: 
fst :: (a, b) -> a
fst (x, _) = x
head :: [a] -> a
head (x:_) = x
zip :: [a] -> [b] -> [(a, b)]
-- A parametically polymorphic function cannot inspect the type variable. 
-- Length never loos at the list elements - it just counts them 
-- This constraint is actually powerful: it measn the type signature alone tells you a lot about what the function can and cannot do

-- Some functions cannot work for every type - They need the type to support certain operations
-- For example (+) and this only makes sense for numeric types, Haskell handles this with class contraints
(+) :: Num a => a -> a -> a
-- For any type a that is an instance of the class Num (+) takes two values of that type and returns a value of the same type

-- A class is a collection of types that share a common characteristic. These are specified overloaded operations called methods
-- A class defines an interface - what operations a type must support to be a member
-- An instance is a concrete implementation of a class for a specific type, provides implementations of the required methods
-- For example, Int is an instance of Num because it provides implementations of (+), (*), etc. A class defines an interface - what operations a type must supoort to be a member

-- Basic Type Classes
-- Eq - This provdies an equaltion operator == and /=
-- Ord - This provides ordering which is a subclass of Eq and defines <, >, <=, >=
-- Show - Convert to strings for display and this is just the command show 
-- Read - Parse from String and this is just the command read
-- Num - Numeric Operations so + - * etc

-- Defining your own class
-- You can define entirely new type classes. A class definition specfies an interface: the method that any instance must implement
class Foo a where
isfoo :: a -> Bool
-- This says "Foo is a class". Any type a that wants to be an instance of Foo must provide an implementation of isfoo, 
-- which takes a value of type a and returns a value of type Bool
-- Making types instances of the class
instance Foo Int where
isfoo _ = False
instance Foo Char where
isfoo c = c `elem` ['a', 'e', 'i', 'o', 'u']
-- Now Int and Char are both instances of Foo, each with their own implementation of isfoo. 
-- The lecturer emphasised that this is very flexible: you can add new interfaces to old types and new types to old interfaces

-- Making type instances: deriving vs instance
-- There are two ways to make your type an instance of a class
-- Method 1: deriving (automatic, default behaviour)
data IsTrue = Yes | No | Perhaps
deriving (Eq, Ord, Show)
-- This tells haskell to automatically generate instances of the Eq, Ord and Show type classes for the IsTrue type
-- This is the default behaviour. 
-- For Eq, this means each constructor equals itself. 
-- For Ord, the ordering follows the order in which constructors are listed (so Yes < No < Perhaps)
-- For Show, it just prints the constructor name  

-- Method 2: instance (manual)
instance Eq IsTrue where
Yes == Yes = True
No == No = True
Perhaps == Perhaps = True
_ == _ = False
-- This gives you full control. You can define equality (or any method) however you wish
-- This is useful as a long as the type signature matches what the class requires 

-- Classes can provide default implementations of methods, so that instances only define a subset
-- The Eq class is a perfect example
class Eq a where
(==) :: a -> a -> Bool
x == y = not (x /= y)
-- This is the default implementation of ==
(/=) :: a -> a -> Bool
x /= y = not (x == y)
-- This is the default implementation of /=
-- Since (==) and (/=) are defined in terms of each other, this is a complete implementation of Eq
-- You only need to provide one of them
-- This is called the minimal complete definition
-- For Eq, the minimal complete definition is either (==) or (/=)

-- Multiple Class Constraints
-- A function can require multiple class constraints on the same or different type variables
-- Lecturer gave this example in class
-- This function needs BOTH Num and Ord
-- Num because we do x + 2
-- Ord because because we do <= 12
noMoreThanTen :: (Num a, Ord a) => a -> Bool
noMoreThanTen x = x <= 10
-- The constraints are listed in pathentheses, separated by commas before the function body so =>. 
-- If a function takes multiple arguments of different types each can have its own constraints
someFunc :: (Num a, Show b) => a -> b -> String
someFunc x y = show y ++ "plus one " ++ show (x + 1)

-- This is an example the lecturer gave in class
data IsTrue = Yes | No | Perhaps
-- Then we tested this in GHCi by typing
-- > x = Yes
-- :type x
x :: IsTrue
-- He did this because he wanted to show that Haskell can recoginise this type and its constructors
-- But that doesnt mean you can do anything useful with values of the type yet 
-- Then he did x == y and got No instance for (Eq IsTrue) 
-- This happens because we never told Haskell to compare two IsTrue values for equality
-- The == operator requires the type for be in the Eq class and IsTrue isnt. 
-- This is the same error from Lecture 5 but now we understand that this is a missing class instance
-- Also just typing > Yes produces an error about no instance for Show IsTrue
-- GCHi can recognise that Yes is of type IsTrue but can't print it because it does't know how to convert it into a string
-- That requires the show class 
-- This is because the error was because IsTrue wasnt in the Show class
-- Then he modified the definition to 
data IsTrue = Yes | No | Perhaps
deriving (Eq)
-- He did thsi to show that deriving (Eq) gives you default equality, each constructor only equals itself
-- Then we trued Up Yes <= Up No and gets an No instance
-- This happens because <= operator requires the type to be in the ord class 
-- Then he attempted this 
data IsTrue = Yes | No | Perhaps
deriving (Ord)
-- Then he tried to compare Yes == No and got Yes /= No
-- This gets you an error saying that Ord requires Eq - cant have ordering without equality
-- This is because Ord is a subclass of Eq. 
-- The minimal definition of Ord needs <= and >= 
data IsTrue = Yes | No | Perhaps
deriving (Eq, Ord, Show)
-- When you derive Ord, Haskell uses the order in which the constructors are written in the data declaration
-- Yes is listed first, so its the smallest and perhaps is listed list so its the largest
-- He then defined a new type that wraps IsTrue
data Optimistic = Up IsTrue
deriving (Show)
-- Now he derives Show so we can print values
-- But does not derive Eq because to define a custom equality where perhasps counts as yes
instance Eq Optimistic where
(Up Yes) == (Up Perhaps) = True
(Up Perhaps) == (Up Yes) = True
(Up x) == (Up y) = x == y
-- The purpose of what my lecturer has done is to show you that you can define your own classes and instance them for types
-- This is very useful for defining your own types
-- You can also define your own type classes
-- You can also define your own instances
-- When you need custom behaviour you use instance to write your own implementations

