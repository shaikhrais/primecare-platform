package testNG.LinkedIN;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;
import pageobjects.LinkedIn.LinkedInHomePage;
import pageobjects.LinkedIn.LinkedInLoginPage;
import base.baseTest;

public class LinkedInPostTest extends baseTest {

	private WebDriver driver;
	private String username = "your_linkedin_username";
	private String password = "your_linkedin_password";

	LinkedInLoginPage loginPage;
	LinkedInHomePage homePage;

	@Override
	@BeforeMethod
	public void setUp() {
		System.setProperty("webdriver.chrome.driver", "path/to/chromedriver");
		driver = new ChromeDriver();
		driver.get("https://www.linkedin.com/");
	}

	@Test
	public void createAndUploadPost() {
		// Login
		loginPage = new LinkedInLoginPage();
		loginPage.usernameInput.sendKeys(username);
		loginPage.passwordInput.sendKeys(password);
		loginPage.loginButton.click();

		// Navigate to Home Page
		homePage = new LinkedInHomePage();
		homePage.homeTab.click();
		homePage.startPostButton.click();

		// Write and post content
		WebElement postContent = driver.findElement(By.cssSelector("div[role='textbox']"));
		postContent.sendKeys("This is my LinkedIn post!");

		// Click the 'Post' button
		homePage.postButton.click();

		// Add additional logic for uploading media, etc.
	}

	@Override
	@AfterMethod
	public void tearDown() {
		driver.quit();
	}
}
