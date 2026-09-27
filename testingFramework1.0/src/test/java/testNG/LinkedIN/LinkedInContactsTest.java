package testNG.LinkedIN;

import org.openqa.selenium.WebDriver;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;
import pageobjects.LinkedIn.LinkedInConnectionsPage;
import pageobjects.LinkedIn.LinkedInHomePage;
import pageobjects.LinkedIn.LinkedInLoginPage;
import base.baseTest;

public class LinkedInContactsTest extends baseTest {

	private WebDriver driver;
	private String username = "your_linkedin_username";
	private String password = "your_linkedin_password";

	LinkedInLoginPage loginPage;
	LinkedInHomePage homePage;
	LinkedInConnectionsPage connectionsPage;

	@Override
	@BeforeMethod
	public void setUp() {

		driver.get("https://www.linkedin.com/");
	}

	@Test
	public void extractLinkedInContacts() {
		// Login
		loginPage = new LinkedInLoginPage();
		loginPage.usernameInput.sendKeys(username);
		loginPage.passwordInput.sendKeys(password);
		loginPage.loginButton.click();

		// Navigate to Connections page
		homePage = new LinkedInHomePage();
		homePage.homeTab.click();
		homePage.connectionsLink.click();

		// Wait for the connections page to load
		// ...

		// Extract information from the connections page
		connectionsPage = new LinkedInConnectionsPage();
		String connectionsSummaryText = connectionsPage.connectionsSummary.getText();
		System.out.println("Connections Summary: " + connectionsSummaryText);

		// Add more code to extract other contact information as needed
		// ...
	}

	@Override
	@AfterMethod
	public void tearDown() {
		driver.quit();
	}
}
