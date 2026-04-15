package practical2;

abstract class Transport {
    private String model; 
    public Transport(String model) {
        this.model = model;
    }
    abstract void move();
    public String showModel() {
        return "Model: " + model;
    }
}

interface SelfDriving {
    public void autoPilot();
}

class AutonomousCar extends Transport implements SelfDriving {
    public AutonomousCar(String model) {
        super(model);
    }
    @Override
    public void move() {
        System.out.println("Autonomous car is moving");
    }
    @Override
    public void autoPilot() {
        System.out.println("Autonomous car is using auto pilot");
    }
}

class AutonomousDrone extends Transport implements SelfDriving {
    public AutonomousDrone(String model) {
        super(model);
    }
    @Override
    public void move() {
        System.out.println("Autonomous drone is moving");
    }
    @Override
    public void autoPilot() {
        System.out.println("Autonomous drone is using auto pilot");
    }
}