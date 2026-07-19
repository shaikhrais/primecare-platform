package PageObjects.LinkedIn;

import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import base.baseTest;

public class LinkedInHomePage extends baseTest {

	@FindBy(css = "span[data-test-id='home-tab-icon']")
	public WebElement homeTab;

	@FindBy(css = "div[role='button'][aria-label='Start a post']")
	public WebElement startPostButton;

	@FindBy(css = "div[role='button'][aria-label='Post']")
	public WebElement postButton;

	@FindBy(css = "a[data-control-name='connections']")
	public WebElement connectionsLink;

	public LinkedInHomePage() {
		PageFactory.initElements(driver, this);
	}
}
