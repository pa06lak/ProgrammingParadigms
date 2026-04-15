package practical2;

abstract class Appliance {
    String brand; // this is the instance variable 
    // Instance variable is a variable that belongs to an object (instance) of a class
    // It stores data specific to each object created from a class
    // If this had public or private it would still be an instance variable
    public Appliance(String brand) {
        this.brand = brand;
    }
    abstract void showFunction(); // curly brackets are not needed for this
    public String displayBrand() {
        return "Brand: " + brand;
    }
}

// This is an interface called SmartDevice
// This is an interface because it has no implementation
interface SmartDevice {
    void connectToWiFi();
}

// this class doesnt use private or public because it extends another class
class SmartFridge extends Appliance implements SmartDevice {
    public SmartFridge(String brand) {
        super(brand);
    }
    // If you extend an abstract class you must implement its abstract methods
    // If you implement an interface you must implement its methods
    @Override
    public void showFunction() {
        System.out.println("This is a Smart Fridge");
    }
    @Override
    public void connectToWiFi() {
        System.out.println("Connected to WiFi");
    }
}

