package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth258BillingadmincompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 258;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billing_admin_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billing_admin_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billing_admin_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billingadmincompliance-btn-1')]")
	private WebElement billingadmincomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billingadmincompliance-btn-5')]")
	private WebElement billingadmincomplianceBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billingadmincompliance-btn-3')]")
	private WebElement billingadmincomplianceBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billingadmincompliance-btn-2')]")
	private WebElement billingadmincomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billingadmincompliance-content')]")
	private WebElement billingadmincomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billingadmincompliance-title')]")
	private WebElement billingadmincomplianceTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billingadmincompliance-btn-4')]")
	private WebElement billingadmincomplianceBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billingadmincompliance-screen')]")
	private WebElement billingadmincomplianceScreen;

    public Auth258BillingadmincompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth258BillingadmincompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth258BillingadmincompliancescreenScreen", "/staff/billing-admin-compliance");
    }
}
