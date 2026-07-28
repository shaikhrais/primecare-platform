package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic677FamilymemberbillingscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 677;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_member_billing-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_member_billing-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_member_billing-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'familymemberbillingscreen-screen')]")
	private WebElement familymemberbillingscreenScreen;

    public Clinic677FamilymemberbillingscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic677FamilymemberbillingscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic677FamilymemberbillingscreenScreen", "/generated/family-member-billing");
    }
}

