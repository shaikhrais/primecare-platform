package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic862HeadofmarketingleadsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 862;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_marketing_leads-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_marketing_leads-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'head_of_marketing_leads-content')]")
	private WebElement primaryContent;

    public Clinic862HeadofmarketingleadsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic862HeadofmarketingleadsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic862HeadofmarketingleadsscreenScreen", "/generated/head-of-marketing-leads");
    }
}

