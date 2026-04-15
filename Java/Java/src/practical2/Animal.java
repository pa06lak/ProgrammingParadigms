package practical2;

// This is to create an abstract class
abstract class Animal {
    String name; // instance variable name

    public Animal(String name) {
        this.name = name;
    }

    abstract void makeSound();

    public String displayInfo() {
        return "Name: " + name;
    }

}
// This is to create a child class
class Dog extends Animal {
    public Dog(String name) {
        super(name);
    }
    // This is to override the abstract method
    @Override
    void makeSound() {
        System.out.println("Woof!");
    }
}

class Cat extends Animal {
    public Cat(String name) {
        super(name);
    }
    // This is to override the abstract method
    @Override
    void makeSound() {
        System.out.println("Meow!");
    }
}