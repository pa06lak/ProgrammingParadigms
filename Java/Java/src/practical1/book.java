package practical1;

// Create a book class with the following private fields
public class book {
    private String title;
    private String author;
    private double price;

    // Create a constructor
    public book(String title, String author, double price) {
        this.title = title;
        this.author = author;
        this.price = price;
    }

    // Now get the getter methods to retrieve all the fields
    public String getTitle() {
        return title;
    }
    public String getAuthor() {
        return author;
    }
    public double getPrice() {
        return price;
    }
}

// In the main method 
