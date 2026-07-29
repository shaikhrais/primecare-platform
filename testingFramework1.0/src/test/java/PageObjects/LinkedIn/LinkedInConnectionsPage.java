package pageobjects.LinkedIn;

import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import base.baseTest;

public class LinkedInConnectionsPage extends baseTest {

	@FindBy(css = "div[class*='mn-connections-summary']")
	public WebElement connectionsSummary;

	// Add more elements for other fields as needed

	public LinkedInConnectionsPage() {
		PageFactory.initElements(driver, this);
	}
}
