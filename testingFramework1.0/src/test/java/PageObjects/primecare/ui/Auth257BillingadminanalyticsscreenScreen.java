package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth257BillingadminanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 257;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billing_admin_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billing_admin_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billing_admin_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billingadminanalytics-content')]")
	private WebElement billingadminanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billingadminanalytics-btn-1')]")
	private WebElement billingadminanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billingadminanalytics-btn-2')]")
	private WebElement billingadminanalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billingadminanalytics-title')]")
	private WebElement billingadminanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billingadminanalytics-screen')]")
	private WebElement billingadminanalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billingadminanalytics-btn-3')]")
	private WebElement billingadminanalyticsBtn3;

    public Auth257BillingadminanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth257BillingadminanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth257BillingadminanalyticsscreenScreen", "/staff/billing-admin-analytics");
    }
}

