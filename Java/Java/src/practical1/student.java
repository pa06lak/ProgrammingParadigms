package practical1;
// This question is testing constructor overloading
// This works because Java looks at the parameters, not just the name
// This is called method overloading and this is a special case 
// You are not creating duplicate functions you are creating different versions of the same function
// So different objects would go to different functions


public class student {
    private String name;
    private int age;
    private double grade;

    public student(String name, int age, double grade) {
        this.name = name;
        this.age = age;
        this.grade = grade;
    }
    public student(String name, int age) {
        this.name = name;
        this.age = age;
        this.grade = 0;
    }
    public String displayInfo() {
        return "Name: " + name + "\nAge: " + age + "\nGrade: " + grade;
    }
}
