package practical3;

public class RentalService {
    public void rentVehicle(Vehicle vehicle, int days) {
        int totalCost = vehicle.calculateRentalCost(days);
        System.out.println("Total Rental Cost: $" + totalCost);
    }
    public void rentVehicle(Vehicle vehicle) {
        // Need to make the default number of days 1
        int totalCost = vehicle.calculateRentalCost(1);
        System.out.println("Total Rental Cost: $" + totalCost);
    }
}
