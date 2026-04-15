package practical1;

public class employee {
    private String name;
    private double salary;
    // Need to have a static variable 'companyName' shared among all employees
    private static String companyName = "ABC Company";

    public employee(String name, double salary) {
        this.name = name;
        this.salary = salary;
    }

// static void means this method can be called without creating an instance of the class
// static means that this belongs to the class
// void means it returns nothing
// This uses static because company name is shared by all employees so this acts on a shared class data or utility behaviour 
    public static void setCompanyName(String newCompanyName) {
        companyName = newCompanyName;
    }

    public void displayInfo() {
        System.out.println("Name: " + name);
        System.out.println("Salary: $" + salary);
        System.out.println("Company: " + companyName);
    }

}
