package PageObjects.Instagram;

import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import base.baseTest;

public class InstagramHomePage extends baseTest {

	@FindBy(xpath = "//div[@role='menuitem']/div/div/div/div[3]/div[1]/div/div[1]")
	public WebElement createPostButton;

	@FindBy(xpath = "//div[@role='menuitem']/div/div/div/div[3]/div[2]/div/div[1]")
	public WebElement createReelButton;

	public InstagramHomePage() {
		PageFactory.initElements(driver, this);
	}
}
