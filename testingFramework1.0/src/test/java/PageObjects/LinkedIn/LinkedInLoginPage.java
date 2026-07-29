package pageobjects.LinkedIn;

import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import base.baseTest;

public class LinkedInLoginPage extends baseTest {

	@FindBy(id = "username")
	public WebElement usernameInput;

	@FindBy(id = "password")
	public WebElement passwordInput;

	@FindBy(css = "button[type='submit']")
	public WebElement loginButton;

	public LinkedInLoginPage() {
		PageFactory.initElements(driver, this);
	}
}
