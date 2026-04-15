# Lecture 5 – Key Concepts (Quick Answers)

## 1. When to use a Class vs an Interface

### Use a **Class** when:
- You want to **create objects**
- You need to **store data (instance variables)**
- You want to provide **implementation (actual code)**
- You want to share **common behaviour**

👉 Example: `Book`, `Student`, `BankAccount`

---

### Use an **Interface** when:
- You want to define a **set of rules (methods)**
- You don’t care *how* something is done, only *that it is done*
- You want **multiple classes to follow the same structure**
- You need **multiple inheritance**

👉 Example: `Comparable`, `Runnable`, `Payment`

---

### Simple summary:
- **Class = implementation (HOW)**
- **Interface = contract (WHAT)**

---

## 2. What does `final` mean?

👉 A `final` variable **cannot be changed once assigned**

### Example:
final int x = 10;
x = 20; // ❌ ERROR

## 🔹 Static Variables

👉 Belong to the **class**, not individual objects

public class Book {
    static int count = 0;
}

Explanation:
A static variable is shared across all instances of a class
Only one copy exists, no matter how many objects you create
If one object changes it, the change is reflected for all objects

🔹 Static Methods

👉 Belong to the class, not objects

public class MathUtils {
    public static int add(int a, int b) {
        return a + b;
    }
}

Explanation:
Static methods can be called without creating an object
They are used for utility or helper functions
They cannot directly access instance variables because those belong to objects

# Interfaces as a Type

## 🧠 Core Idea

👉 You can use an **interface as a type** instead of a specific class.

This means:

> “I don’t care what the object is — as long as it follows these rules.”

---

## 🔍 Example Interface

public interface Animal {
    void makeSound();
}

 Java Interfaces & Inheritance Concepts

---

## 🔹 Static Methods (Java 8+)

- Called using the **interface name**, not an object:
  SaysHello.helloWorld();
Not inherited by implementing classes
Cannot be overridden
- Default Methods (Java 8+)
Use the default keyword — if omitted, abstract is assumed
Are inherited by implementing classes
Can be overridden by implementing classes
Provide a fallback implementation that subclasses get “for free”
- The Rule (Inheritance in Java)
Java does NOT allow multiple inheritance of classes
→ A class can extend only one superclass
Java DOES allow a class to implement multiple interfaces
Other languages like C++ allow multiple class inheritance, but this can lead to complex problems
### The Diamond Problem
🧠 Scenario
Class A has a method foo()
Classes B and C both inherit from A and override foo() differently
Class D inherits from both B and C

👉 Question:

Which version of foo() should D use?

❌ There is no clear answer — this is called the Diamond Problem

🚫 How Java Solves It

Java avoids this problem completely by:

Not allowing multiple class inheritance
✅ Why Interfaces Don’t Have This Problem
Interface methods are abstract → no conflicting implementations
The implementing class provides one clear implementation
If two interfaces have the same default method, the class must explicitly resolve the conflict
💡 Lecturer’s Insight

“The big advantage of interfaces: all methods are abstract, so the implementation doesn't exist yet. If two interfaces have the same method, the class just provides one implementation. That's how you elegantly get out of the issue.”

# UML Relationships

In previous lectures, we learned four types of UML relationships. This lecture adds a fifth:

- **Association (solid arrow →)** — A class creates/uses an object of another class.

- **Composition (solid line with filled diamond ◆→)** — Strong ownership; content is destroyed with the container.

- **Aggregation (solid line with hollow diamond ◇→)** — Weak ownership; content survives if the container is destroyed.

- **Inheritance (solid arrow with hollow triangle △)** — Child class inherits from parent class.

- **Dependency (dashed arrow - - →)** — A class uses another class but does not create/own an object of it.

---

## Dependency Example

A `BankUser` has a `BankAccount` (association — it stores one as a field).  
However, it only uses a `Calculator` when one is passed to a method (dependency — no stored reference).


Polymorphism — Objects and methods can take many forms. We can treat objects as different
classes depending on the scenario, and we can override or hide methods.

# Polymorphism in Java

## 🔹 Overview

In Java, polymorphism is achieved through three mechanisms:

- **Method Overloading** — Compile-time polymorphism  
- **Method Overriding** — Run-time polymorphism  
- **Upcasting and Downcasting** — Type conversion within inheritance hierarchies  

---

## ✅ Benefits of Polymorphism

- Improves **code reusability**  
- Increases **flexibility**  
- Enhances **maintainability**  

👉 You can write **one method** that works for a range of objects, as long as they share a **common superclass or interface**.

---

## 🔹 Types of Polymorphism in Java

| Type              | Mechanism                     | When Resolved                  | Key Idea                                  |
|------------------|------------------------------|--------------------------------|-------------------------------------------|
| Compile-time     | Method Overloading           | By the compiler before running | Same name, different parameters           |
| Run-time         | Method Overriding            | While the program is running   | Subclass replaces superclass method       |
| Type Conversion  | Upcasting & Downcasting      | Both compile-time and run-time | Treating objects as different types       |

---

## 🔹 Compile-Time vs Run-Time

### Compile-time
- Happens when the compiler translates code into bytecode  
- Errors caught here:
  - Syntax errors  
  - Type mismatches  

---

### Run-time
- Happens when the program is actually executing  
- Errors caught here:
  - Invalid casting  
  - Running out of memory  

---

## 🎯 Summary

- **Compile-time polymorphism** → decided before execution  
- **Run-time polymorphism** → decided during execution  
- Polymorphism allows one interface to be used for many different implementations  

The lecturer gave this example: 'If you write bad syntax, the compiler tells
you immediately — that's a compile-time error. But if you try to allocate an array that needs
160GB on a laptop with 16GB, the compiler can't detect that problem — it's perfectly legal code.
That will only fail at runtime.'

# Method Overloading & Method Overriding

---

## 🔹 Method Overloading (Compile-Time Polymorphism)

### Key Rules
1. Multiple methods with the same name but **different parameters** (different signature)  
2. Happens within the **same class**  
3. Resolved at **compile-time** — the compiler can see which version to call based on the argument types  

---

### Example

class MathUtils {
    int add(int a, int b) { return a + b; }
    double add(double a, double b) { return a + b; }
}
Explanation
add(3, 5) → compiler uses the int version
add(3.0, 5.0) → compiler uses the double version

👉 Everything the compiler needs to decide is available at compile-time

💡 Lecturer’s Insight

“If you have two unrelated classes that happen to have methods with the same name, that's NOT overloading — they never interact. Overloading is within the same class.”

🔹 Method Overriding (Run-Time Polymorphism)
Key Rules
A subclass provides a specific implementation of a superclass method
Requires inheritance — the subclass extends the superclass
Use the @Override annotation (strongly recommended)
Resolved at run-time — depends on the actual object type, not the reference type
Example
class Animal {
    void makeSound() {
        System.out.println("Animal makes a sound");
    }
}

class Dog extends Animal {
    @Override
    void makeSound() {
        System.out.println("Bark!");
    }
}
🧠 Why is this run-time?

When you have:

Animal a = new Dog();
a.makeSound();

👉 Java checks at run-time:

The reference type is Animal
The actual object is Dog

✔ So it calls the Dog’s version of makeSound()

Interfaces enable polymorphism by letting completely unrelated classes share a common set of
method signatures. This facilitates loose coupling — components have minimal interdependencies.
Loose coupling: If you change the internal implementation inside Boat or Fish, the Swimmable
interface doesn't need to know or change. The dependency is one-way.

Upcasting means assigning a subclass object to a superclass reference. It is typecasting
the object 'upward' in the inheritance hierarchy.
Upcasting is when you take a subclass object and store it in a superclass reference. Think of it as zooming out - you're saying that you don't care about specifics, just treat this as the more general type

Car myCar = new Car("Tesla", 50.0, 5);

// Upcasting: storing a Car in a Vehicle reference
Vehicle v = myCar;  // implicit, no cast needed

The object in memory is still a car so that has not changed. But through the v reference, you can only things that Vehicle knows about. So v.displayDetails() works (Vehicle has that), but v.seatingCapacity doesn't - because as far as v is concerned it is just a Vehicle

• All members of the superclass are accessible.
• If methods are overridden: the overridden (subclass) version is called at runtime.
• Subclass-specific members that don't exist in the superclass are NOT accessible.
• Upcasting can be done implicitly (most common) or explicitly.
Even though myPet is declared as type Animal, it holds a Dog object. When makeSound() is
called, Java uses the Dog's overridden version — this is run-time polymorphism in action.

One of the most powerful uses of upcasting: writing a single method that accepts any subclass via a superclass parameter.
Output: Ook, Roar, Moo — NOT 'Animal sound' three times! The overridden methods are called
because the actual objects are Ape, Bear, and Cow.
When you upcast, you can only access members that exist in the superclass.
Subclass-specific methods and fields are NOT accessible through the superclass reference
■ Lecturer's Insight: 'This is the downside of upcasting. You can only access stuff which is in
the superclass because you've cast it into the superclass. This is also another reason why
interfaces are so useful — they define exactly what must be available.'

Downcasting means converting (typecasting) a superclass reference back to a subclass
reference. It must be done explicitly — you write the target type in parentheses. It gives you
access to subclass-specific members.
Downcasting is the reverse - you're zooming back in to the specific subclass because you need access to something only the subclass has 
Key points about downcasting:
• Must be explicit — you always write (SubclassName) before the reference.
• Gives back access to subclass-specific methods and fields.
• Only works if the object was originally that subclass type (or a subclass of it).
• Can cause runtime errors if used incorrectly — always check with instanceof first.

