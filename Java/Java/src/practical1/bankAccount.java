package practical1;

public class bankAccount {
    private static int totalAccounts = 0; // Shared account across all accounts
    private int accountNumber;
    private double balance;

    public bankAccount(int accountNumber, double balance) {
        this.accountNumber = totalAccounts ++;
        this.balance = balance;
    }

    public void deposit(double amount) {
        balance += amount;
    }

    public void withdraw(double amount) {
        if (amount > 0 && amount <= balance) {
            balance -= amount;
        } else {
            System.out.println("Invalid withdrawal amount.");
        }
    }

    public static void displayTotalAccounts() {
        System.out.println("Total number of accounts: " + totalAccounts);
    }
}
