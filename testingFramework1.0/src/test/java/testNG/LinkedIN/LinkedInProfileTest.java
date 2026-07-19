package testNG.LinkedIN;

import java.util.List;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import PageObjects.LinkedIn.LinkedInLoginPage;
import PageObjects.LinkedIn.LinkedInProfilePage;

public class LinkedInProfileTest {

	private WebDriver driver;
	private String username = "your_linkedin_username";
	private String password = "your_linkedin_password";

	LinkedInLoginPage loginPage;
	LinkedInProfilePage profilePage;

	@BeforeMethod
	public void setUp() {
		System.setProperty("webdriver.chrome.driver", "path/to/chromedriver");
		driver = new ChromeDriver();
		driver.get("https://www.linkedin.com/");
	}

	@Test
	public void extractProfileInformation() {
		// Login
		loginPage = new LinkedInLoginPage();
		loginPage.usernameInput.sendKeys(username);
		loginPage.passwordInput.sendKeys(password);
		loginPage.loginButton.click();

		// Navigate to the user's profile
		driver.get("https://www.linkedin.com/in/your_profile_id");

		// Wait for the profile to load (you might need explicit waits)
		// ...

		// Extract profile information
		profilePage = new LinkedInProfilePage();
		String profileName = profilePage.profileName.getText();
		System.out.println("Profile Name: " + profileName);

		// Extract experiences
		List<WebElement> experiences = profilePage.experiences;
		for (WebElement experience : experiences) {
			System.out.println("Experience: " + experience.getText());
		}

		// Add more code to extract other profile fields as needed
		// ...

	}

	@AfterMethod
	public void tearDown() {
		driver.quit();
	}
}
