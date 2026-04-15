package practical3;
import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        Car car1 = new Car("Honda Civic", 50.0, 5);
        System.out.println(car1.displayDetails());
        System.out.println(car1.calculateRentalCost(5));
        Bike bike1 = new Bike("Honda CBR", 30.0);
        System.out.println(bike1.displayDetails());
        System.out.println(bike1.calculateRentalCost(3));
        RentalService rentalService = new RentalService();
        rentalService.rentVehicle(car1, 5);
        System.out.println("Something ");
        System.out.println(car1.calculateRentalCost(3, false));
        bike1.calculateRentalCost(3, true);
        // Create an array of Transport objects containing both Car and Bike objects
        Transport[] vehicles = {car1, bike1}; // You can also use new Transport[] {car1, bike1}
        for (Transport vehicle : vehicles) {
            System.out.println(vehicle.showModel());
            vehicle.move();
        }
        // Need to see if the car implements LuxutyService
        car1.offerLuxuryPackage(true);

        // This is now for exercise 3.2 
        // Need to create a manager object but store it in an Employee variable (Upcasting)
        Employee employee1 = new Manager("John Doe", 50000);
        employee1.work();
        Manager manager1 = (Manager) employee1;
        manager1.conductMeeting();

        if (employee1 instanceof Manager) {
            Manager manager2 = (Manager) employee1; // Downcasting
            manager2.conductMeeting();
        }

        List<Employee> staff = new ArrayList<>(); // You can also use ArrayList<Employee> staff = new ArrayList<>();
        staff.add(new Employee("Bob", 40000));
        staff.add(new Manager("Alice", 75000));
        staff.add(new Employee("Charlie", 42000));
        staff.add(new Manager("Diana", 80000));

        for (Employee employee : staff) {
            employee.work();
            // Check if the employee is a manager
            if (employee instanceof Manager) { // Downcasting
                Manager manager = (Manager) employee; // Downcasting
                manager.conductMeeting(); // Call the method
            }
        }
    }
}
