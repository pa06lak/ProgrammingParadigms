package practical2;

interface Flyable {
    public void fly();
}

interface Swimmable {
    public void swim();
}

public class Duck implements Flyable, Swimmable {
    @Override
    public void fly() {
        System.out.println("Duck is flying");
    }
    @Override
    public void swim() {
        System.out.println("Duck is swimming");
    }
}
