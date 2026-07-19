package testNG.USdateChecker;


import java.time.Duration;

import org.testng.annotations.Test;

import PageObjects.GoogleMaps.PointClickCare;
import PageObjects.USdateChecker.LoginScreen;
import PageObjects.USdateChecker.ReschedulePage;
import PageObjectsPoint.ClickCare.HomePage;
import PageObjectsPoint.ClickCare.PatientsListPage;
import base.baseTest;

public class dateCheckerTest extends baseTest {

	private String username;
    private String password;
    private String location;
    private int targetDays;

	PointClickCare pointClickCare;

	HomePage homePage;
	PatientsListPage patientsListPage;

	LoginScreen loginPage;

	ReschedulePage reschedulePage;



	@Test
	public void testBookAppointment() throws InterruptedException {


		username = System.getProperty("username");
        password = System.getProperty("password");
        location = System.getProperty("location", "Toronto");
        targetDays = Integer.parseInt(System.getProperty("targetDays", "60"));
        
		loginPage = new LoginScreen();
		reschedulePage =new ReschedulePage(60);


		loginPage.Login("dnkalani98@gmail.com", "Canada@123");
		//loginPage.Login(username, password);
		Thread.sleep(Duration.ofSeconds(1));
		driver.get("https://ais.usvisa-info.com/en-ca/niv/schedule/69377471/continue_actions");
		driver.get("https://ais.usvisa-info.com/en-ca/niv/schedule/69377471/appointment");
		Thread.sleep(Duration.ofSeconds(10));
		//reschedulePage.Login();
		// Book an appointment with available time slot
		// Book an appointment with available time slot
        // Parameters: location, max months to search, max retries, seconds between retries
		//("Toronto", 36);
		String appointmentDetails = reschedulePage.bookAvailableAppointment(location, targetDays);

        // Check the result
        if (appointmentDetails != null) {
            System.out.println("RESULT: " + appointmentDetails);
        } else {
            System.out.println("No available appointments found or system busy");
        }
		//driver.get("https://ais.usvisa-info.com/en-ca/niv/schedule/69377471/appointment");
		//Thread.sleep(Duration.ofSeconds(200));

	}

}
