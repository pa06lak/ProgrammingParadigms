package practical2;

public class main {
    public static void main(String[] args) {
        Dog dog1 = new Dog("Buddy");
        dog1.makeSound();
        dog1.displayInfo();
        Cat cat1 = new Cat("Whiskers");
        cat1.makeSound();
        cat1.displayInfo();
        Car car1 = new Car();
        car1.start();
        car1.stop();
        Bike bike1 = new Bike();
        bike1.start();
        bike1.stop();
        SmartFridge fridge1 = new SmartFridge("Samsung");
        fridge1.showFunction();
        fridge1.connectToWiFi();
        fridge1.displayBrand();
        Duck duck1 = new Duck();
        duck1.fly();
        duck1.swim();
        AutonomousCar car2 = new AutonomousCar("Tesla");
        car2.move();
        car2.autoPilot();
        AutonomousDrone drone1 = new AutonomousDrone("DJI");
        drone1.move();
        drone1.autoPilot();
    }
}
