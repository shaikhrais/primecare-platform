package testNG.USdateChecker;


import org.testng.TestNG;

public class TestRunner {

	public static void main(String[] args) {
        // Default values
		//java -jar usdate-checker-jar-with-dependencies.jar --username "dnkalani98@gmail.com" --password "Canada@123" --location "Toronto" --days "60"
//        String username = "";
//        String password = "";

        String username = "dnkalani98@gmail.com";
        String password = "Canada@123";

        String location = "Toronto";
        int targetDays = 60;

        // Parse command line args
        for (int i = 0; i < args.length; i++) {
            if (args[i].equals("--username") && i+1 < args.length) {
                username = args[i+1];
            }
            if (args[i].equals("--password") && i+1 < args.length) {
                password = args[i+1];
            }
            if (args[i].equals("--location") && i+1 < args.length) {
                location = args[i+1];
            }
            if (args[i].equals("--days") && i+1 < args.length) {
                try {
                    targetDays = Integer.parseInt(args[i+1]);
                } catch (NumberFormatException e) {
                    System.err.println("Invalid number for days parameter: " + args[i+1]);
                }
            }
        }

        // Validate required parameters
        if (username.isEmpty() || password.isEmpty()) {
            System.err.println("Error: Username and password are required!");
            System.err.println("Usage: java -jar usdate-checker.jar --username <username> --password <password> [--location <location>] [--days <targetDays>]");
            System.exit(1);
        }

        // Store parameters as system properties so tests can access them
        System.setProperty("username", username);
        System.setProperty("password", password);
        System.setProperty("location", location);
        System.setProperty("targetDays", String.valueOf(targetDays));

        System.out.println("Starting US Date Checker with parameters:");
        System.out.println("- Username: " + username);
        System.out.println("- Location: " + location);
        System.out.println("- Target Days: " + targetDays);

        // Run the test
        TestNG testng = new TestNG();
        testng.setTestClasses(new Class[] { dateCheckerTest.class });
        testng.run();
    }
}