package practical3;

public class Vehicle {
    // create an instance variable called model and rentalRate
    protected String model; // This is just an instance variable
    protected double rentalRate;
    // constructor
    public Vehicle(String model, double rentalRate) {
        this.model = model;
        this.rentalRate = rentalRate;
    }
    public String displayDetails() {
        return "Model: " + model + "\nRental Rate: $" + rentalRate;
    }
    public int calculateRentalCost(int days) {
        return (int) (rentalRate * days); // we need int here because we are returning an int
    }
    public int calculateRentalCost (int days, boolean insurance) {
        if (insurance) {
            return (int) (rentalRate * days  + 10); // 10% increase
        } else {
            return (int) (rentalRate * days);
        }
    }

}

abstract class Transport extends Vehicle {
    public Transport(String model, double rentalRate) {
        super(model, rentalRate);
    }
    public abstract void move();
    public String showModel() {
        return "Model: " + model; //This would not work if the model was private
    }
}
interface LuxuryService {
    public void offerLuxuryPackage(Boolean LuxuryPackage); 
}
class Car extends Transport implements LuxuryService { //There is no need for public in this class
    private int seatingCapacity; // This is an instance variable
    public Car(String model, double rentalRate, int seatingCapacity) {
        super(model, rentalRate);
        this.seatingCapacity = seatingCapacity;
    }
    // Override display details
    @Override
    public String displayDetails() {
        return super.displayDetails() + "\nSeating Capacity: " + seatingCapacity;
    }
    // You would not need to define any other functions because they have the same behaviour
    @Override
    public void move() {
        System.out.println("Car is moving");
    }
    @Override
    public void offerLuxuryPackage(Boolean LuxuryPackage) {
        if (LuxuryPackage) {
            System.out.println("Luxury package is available");
        } else {
            System.out.println("Luxury package is not available");
        }
    }
}

class Bike extends Transport {
    public Bike(String model, double rentalRate) {
        super(model, rentalRate);
    }
    @Override
    public int calculateRentalCost(int days) {
        return (int) (rentalRate * days * 0.9); // 10% discount
    }
    @Override
    public int calculateRentalCost(int days, boolean insurance) {
        if (insurance) {
            return (int) (rentalRate * days * 0.85); // 15% discount
        } else {
            return (int) (rentalRate * days * 0.9);
        }
        
    }
    @Override
    public void move() {
        System.out.println("Bike is moving");
    }
}


