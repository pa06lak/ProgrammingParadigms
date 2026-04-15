package practical3;

public class Employee {
    protected String name;
    private double salary;

    public Employee(String name, double salary) {
        this.name = name;
        this.salary = salary;
    }
    public void work() {
        System.out.println(name + " is working.");
    }

}

class Manager extends Employee {
    public Manager(String name, double salary) {
        super(name, salary);
    }
    @Override
    public void work() {
        System.out.println(name + " is managing.");
    }

    public void conductMeeting() { 
    }
}

class Developer extends Employee {
    public Developer(String name, double salary) {
        super(name, salary);
    }
    @Override
    public void work() {
        System.out.println(name + " is coding.");
    }
}
