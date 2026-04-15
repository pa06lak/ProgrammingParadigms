package practical1;

public class main {
    // This is the starting point of your program so where everything runs
    public static void main(String[] args) {
        book book1 = new book("The Great Gatsby", "F. Scott Fitzgerald", 10.99);
        System.out.println("Title: " + book1.getTitle());
        System.out.println("Author: " + book1.getAuthor());
        System.out.println("Price: $" + book1.getPrice());
        car car1 = new car("Toyota", 50);
        car1.accelerate(30);
        car1.brake(20);
        System.out.println(car1.displayInfo());
        student student1 = new student("John Doe", 20, 3.5);
        student student2 = new student("Palak", 20);
        System.out.println(student1.displayInfo());
        System.out.println(student2.displayInfo());
        employee employee1 = new employee("John Doe", 50000);
        employee1.displayInfo();
        employee.setCompanyName("XYZ Company");
        employee1.displayInfo();    
        bankAccount account1 = new bankAccount(12345, 1000.0);
        account1.deposit(500.0);
        account1.withdraw(200.0);
        account1.displayTotalAccounts();
    }
}

