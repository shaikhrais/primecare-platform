package pageobjects.Instagram;

import java.time.Duration;

import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import base.baseTest;

public class InstagramLoginPage extends baseTest {

	@FindBy(name = "username")
	public WebElement usernameInput;

	@FindBy(name = "password")
	public WebElement passwordInput;

	@FindBy(css = "button[type='submit']")
	public WebElement loginButton;


	private String username = "sparksprintca@gmail.com";
	private String password = "Rsoft@999";
	private String loginUrl = "https://www.instagram.com/accounts/login/?hl=en";
	private String profileUrl= "https://www.instagram.com/kubeirkamal/";


	public InstagramLoginPage() {
		PageFactory.initElements(driver, this);

		driver.get(loginUrl);
		driver.manage().timeouts().implicitlyWait(Duration.ofSeconds(20));
	}

	public void login() throws InterruptedException
	{
		// action.explicitWait(driver, textboxPassword, 10);

		System.out.println("Before Enter Username");
		usernameInput.clear();
		usernameInput.sendKeys(username);
		System.out.println("After Enter Username.");

		System.out.println("Before Enter Password");
				passwordInput.clear();
				passwordInput.sendKeys(password);
				System.out.println("After Enter Password. Next is Click Submit");

				action.explicitWait(driver, loginButton, 10);
				System.out.println("After Wait");
				loginButton.click();
				action.explicitWait(driver, loginButton, 10);
				Thread.sleep(5000);
				System.out.println("After Click");
				Thread.sleep(5000);
				driver.get(profileUrl);

				System.out.println("After Navigation");


	}

}
