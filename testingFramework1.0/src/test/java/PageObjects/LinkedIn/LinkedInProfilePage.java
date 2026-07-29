package pageobjects.LinkedIn;

import java.util.List;

import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import base.baseTest;

public class LinkedInProfilePage extends baseTest {

	@FindBy(css = "li-icon[type='linkedin-logo']")
	public WebElement linkedInLogo;

	@FindBy(css = "div[class='display-flex align-items-center']")
	public WebElement profileName;

	@FindBy(css = "p[class='pv-entity__secondary-title']")
	public List<WebElement> experiences;

	// Add more elements for other fields as needed

	public LinkedInProfilePage() {
		PageFactory.initElements(driver, this);
	}
}
