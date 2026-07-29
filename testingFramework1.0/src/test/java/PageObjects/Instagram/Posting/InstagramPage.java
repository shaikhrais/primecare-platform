package pageobjects.Instagram.Posting;

import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import base.baseTest;

public class InstagramPage extends baseTest {

	@FindBy(name = "username")
	private WebElement usernameInput;

	@FindBy(name = "password")
	private WebElement passwordInput;

	@FindBy(css = "button[type='submit']")
	private WebElement loginButton;

	@FindBy(xpath = "//input[@type='file']")
	private WebElement fileInput;

	@FindBy(css = "textarea[aria-label='Write a caption…']")
	private WebElement captionInput;

	@FindBy(xpath = "//button[text()='Share']")
	private WebElement shareButton;

	public InstagramPage() {

		PageFactory.initElements(driver, this);
	}

	public void login(String username, String password) {
		usernameInput.sendKeys(username);
		passwordInput.sendKeys(password);
		loginButton.click();
	}

	public void navigateToPostCreationPage() {
		driver.get("https://www.instagram.com/create/campaign/");
	}

	public void uploadImage(String imagePath) {
		fileInput.sendKeys(imagePath);
	}

	public void enterCaption(String caption) {
		captionInput.sendKeys(caption);
	}

	public void sharePost() {
		shareButton.click();
	}
}
