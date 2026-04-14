-- Lecture 4 - Function Evaluation

fibs = 0 : 1 : zipWith (+) fibs (tail fibs) -- The Fibonacci sequence is defined as the first two numbers being 0 and 1, and each subsequent number being the sum of the previous two numbers. The zipWith function takes a binary function and two lists and applies the function to corresponding elements of the lists. In this case, we are adding the Fibonacci sequence to its tail (which is the Fibonacci sequence without the first element) to generate the next Fibonacci number.
-- This defines the entire Fibonacci sequence as a single expression. 
-- This happens because this is using lazy evaluation, so it does not try to compute the whole list upfront
-- Only computes exactly elements as they are needed
-- The expression works as zipwidth takes two lists and adds corresponding elements together. 

-- In the lazy function expressions are not evaluated when they are bound to variables. 
-- Instead, their evaluation is deferred until their result is needed by other computations
-- This allows us to define Infinite data structures, such as the Fibonacci sequence, without causing an immediate infinite loop or memory overflow.
-- This also allows for deferred computation so arguments to functions are not computed until they are actually needed

-- This uses outermost evaluation - when all sub expressions terminate both strategies produce the same result
-- The difference only matters when some sub-expression does not terminate - and that is where most outermost evaluation has a crucial advantage

-- Here the outermost evaluation is applied first and the function is patter matches
-- If any evaluation strategy can produce a result for a given expression, then outermost evlaution will also produce that result
-- Outermost evaluation terminates at least as often as any other evaluation strategy, and it produces the same result as any other strategy when it terminates.
-- In contrast, innermost evaluation may fail to terminate on some expressions that outermost evaluation can handle, because it may get stuck trying to evaluate a sub-expression that never terminates.

-- Example of innermost evaluation getting stuck in an infinite loop
-- Consider the expression: (λx. 1) ((λy. y y)
-- In innermost evaluation, we would first try to evaluate the argument (λy. y y), which leads to an infinite loop as it keeps trying to evaluate itself.
-- In contrast, with outermost evaluation, we would first evaluate the function (λx. 1) and then apply it to the argument without trying to evaluate the argument first, resulting in the correct result of 1 without getting stuck in an infinite loop.

-- However, there is a potential problem with call by name (which is evaluating the outermost first)
-- An argument might be evaluated more than once if it appears multiple times in the function body. Haskell solves this with sharing

-- Sharing: Avoiding redundant computation
-- Sometimes a operation is evaluated twice - once for each occurenece of the argument in the function body
-- Haskell uses sharing to avoid redundant computation. When an expression is evaluated, its result is stored in memory. If the same expression is encountered again, Haskell can reuse the stored result instead
-- Instead of duplicating the expression tree, Haskell represents the expression as a graph where both occurences of n point to the same node
-- When the node is evaluated once, both references immediately see the results
-- The expression graph has both occurences of n pointing to a single node. 
-- When evaluated, the result is computed once and shared. 
-- This gives us the best of both worlds: the termination benefits of call-by-name with the efficiency of call-by-value.

-- To understand when Haskell stops evaluating an expression we need two important definitions: 
-- Normal form: An expression is in normal form if it cannot be reduced any further. In other words, it is fully evaluated and cannot be simplified or transformed into a different expression.
-- Normal Form is an expression where everything is in normal when an expression graph contains no redexes, is finite and acyclic. Everything has been fully evaluated
-- Weak head normal form: An expression is in weak head normal form if it is either a lambda abstraction (a function definition) or a data constructor (a value that is not a function).
-- An expression is in WHNF when the expression is in normal form, OR the topmost node in the expression graph is a constructor. This allows for cycles and unevaluated sub expressions
-- Haskell evaluates expressions to weak head normal form, which means that it will evaluate an expression until it reaches a lambda abstraction or a data constructor. This allows Haskell to avoid unnecessary computations and to work with infinite data structures without getting stuck in an infinite loop.

-- Haskell evaluates expressions using three simple rules
-- Rule 1: Apply reduction rules (functions) outermost first
-- Rule 2: Evaluate children left to right
-- Rule 3: Stop when the expression is in weak head normal form
-- This is fundamentally different from imperative languages where short-short circuit evaluation is a special case hardcoded only for Boolean operators
-- In Haskell, every function gets this behaviour automatically so if an argument is not needed, it is not evaluated

-- Strict Function: A function which requires its arguments to be evaluated before being applied, even when using outermost evaluation
-- Some functions in Haskell are inherently strict - typically arithemtic operations on numeric types.
-- For example (+) needs to know both of its arguments to prioduce a result, so it forces their evaluation
-- Haskell provides the ($!) operator to force the evaluation of an argument before applying a function. 
--For example, f $! x will evaluate x to weak head normal form before applying f to it. 
--This can be useful for improving performance in certain cases where you want to ensure that an argument is evaluated before being used in a function.
-- Lazy evaluation can lead to increased memory usage if large thunks are created, so using strict evaluation with ($!) can help mitigate this issue by ensuring that values are evaluated at the right time.
-- This is sometimes called a space leak
-- Use lazy evaluation for ost things - it gives you infinite data structure and avoids unncessary computation
-- But ofr accumulators in tail recursive functions (like running sums, products, counts) use ($!) to force struct evaluation and avoid space leaks

