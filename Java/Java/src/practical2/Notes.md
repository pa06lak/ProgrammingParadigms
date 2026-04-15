
Encapsulation - Exposing what is necessary

Types are private, public and protected
Without private you can set values to anything even invalid values

Defensive Programming - this is about enduring objects that can never enter an invalid state

When updating parameters use this so that we can reference the parameters clearly

Static variables is used for the class level itself. The parameter is shared across all objects. These variables are shared and you can access these variables using the class names. Static final creates a constant - a value that is shared across all instances and can never be changed. Static methods belong to a class, not specific objects. It cannot access instance (non static) variables or methods directly This is because static methods exist before any objects are created. Cannot make static references to the non static field. Static methods cannot access instance variables. 

Inheritance is a subclass child derived from a superclass. Shared fields and have each specific animal inherit from it. Each child class only adds what makes it unique. Extends keyword establishes inheritance. The subclass inherits all non-private members of the subclass. Private members are NOT inherited - they stay hidden in the parent class. Java allows single inheritance only - a clause can extend only one other class. 

Method overriding - more specific implementation @override before function method overloading - same method different signature. @override function compiler typos immediately. 

A super refers to the parent class. It is used to access parent class methods and constructors

An abstract class is a class that contains one or more abstract methods - methods declared without implementation. Abstract class is something you cannot create objects from, meant to be inherited by other classes. 

Interfaces are similar to abstract classes are fully abstract by default. They define a contract - a set of behaviours that implementing classes must provide. SO this is a list of rules (methods) a class should follow. Java does not allow a class extend multiple casses. But a class can implement multiple interfaces. An interface defines rules the classes must follow, without saying how. 

UML (unified modelling language) class diagrams represent the structure of a system. Each class is drawn as a box with three sections. Top sections: Class Name, Middle section: properties field with their types and bottom section: behaviour methods with their return types. 



