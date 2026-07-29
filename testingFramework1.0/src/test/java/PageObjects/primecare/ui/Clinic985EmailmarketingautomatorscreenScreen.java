package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic985EmailmarketingautomatorscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 985;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'email_marketing_automator-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'email_marketing_automator-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'email_marketing_automator-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'email_marketing_automator_iconbutton_button_1')]")
	private WebElement emailMarketingAutomatorIconbuttonButton1;

    public Clinic985EmailmarketingautomatorscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic985EmailmarketingautomatorscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic985EmailmarketingautomatorscreenScreen", "/generated/email-marketing-automator");
    }
}

