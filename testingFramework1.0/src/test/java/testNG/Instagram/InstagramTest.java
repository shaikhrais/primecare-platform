package testNG.Instagram;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import PageObjects.Instagram.InstagramHomePage;
import PageObjects.Instagram.InstagramLoginPage;

public class InstagramTest {

	private WebDriver driver;
	private String username = "sparksprintca@gmail.com";
	private String password = "Rsoft@999";
	private String loginUrl = "https://www.instagram.com/accounts/login/?hl=en";
	private String profileUrl= "https://www.instagram.com/kubeirkamal/";

	InstagramLoginPage loginPage;
	InstagramHomePage homePage;

	@BeforeMethod
	public void setUp() {
		System.setProperty("webdriver.chrome.driver", "path/to/chromedriver");
		driver = new ChromeDriver();
		driver.get(profileUrl);
	}

	@Test
	public void createAndUploadPostAndReel() {
		// Login
		loginPage = new InstagramLoginPage();
		loginPage.usernameInput.sendKeys(username);
		loginPage.passwordInput.sendKeys(password);
		loginPage.loginButton.click();

		// Navigate to Home Page
		homePage = new InstagramHomePage();
		homePage.createPostButton.click();

		// Perform actions to create and upload a post

		homePage.createReelButton.click();

		// Perform actions to create and upload a reel
	}

	@AfterMethod
	public void tearDown() {
		driver.quit();
	}
}
