package practical2;

// Define an interface called Vehicle
// This is the skeleton code that we build on top of
interface Vehicle {
    public void start();
    public void stop();
}

// Define a class called Car that implements the Vehicle interface
// We use implement here and not extends
// Remember as you are doing inheritance and polymorphism you need to do override before the function 
class Car implements Vehicle {
    @Override
    public void start() {
        System.out.println("Car started");
    }
    @Override
    public void stop() {
        System.out.println("Car stopped");
    }
}

class Bike implements Vehicle {
    @Override
    public void start() {
        System.out.println("Bike started");
    }
    @Override
    public void stop() {
        System.out.println("Bike stopped");
    }
}
