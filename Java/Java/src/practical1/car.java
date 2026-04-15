package practical1;

public class car {
    private String brand;
    private int speed;

    public car(String brand, int speed) {
        this.brand = brand;
        this.speed = speed;
    }

    public int accelerate(int increase) {
        speed = speed + increase;
        return speed;
    }

    public int brake(int decrease) {
        if (speed - decrease < 0) {
            speed = 0;
            return speed;
        } else {
            speed = speed - decrease;
            return speed;
        }
    }

    public String displayInfo() {
        return "Brand: " + brand + "\nSpeed: " + speed;
    }
}

