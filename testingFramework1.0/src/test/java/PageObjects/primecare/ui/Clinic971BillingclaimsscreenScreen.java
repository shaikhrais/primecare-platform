package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic971BillingclaimsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 971;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billing_claims-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billing_claims-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billing_claims-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billing_claims_screen_outlinedbutton_button_1')]")
	private WebElement billingClaimsScreenOutlinedbuttonButton1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billing_claims_screen_iconbutton_button_1')]")
	private WebElement billingClaimsScreenIconbuttonButton1;

    public Clinic971BillingclaimsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic971BillingclaimsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic971BillingclaimsscreenScreen", "/generated/billing-claims");
    }
}

