package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client75BillingadmindashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 75;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billing_admin_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billing_admin_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billing_admin_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billingadmindashboard-title')]")
	private WebElement billingadmindashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billingadmindashboard-content')]")
	private WebElement billingadmindashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billingadmindashboard-btn-2')]")
	private WebElement billingadmindashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billingadmindashboard-screen')]")
	private WebElement billingadmindashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billingadmindashboard-btn-4')]")
	private WebElement billingadmindashboardBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billingadmindashboard-btn-3')]")
	private WebElement billingadmindashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billingadmindashboard-btn-1')]")
	private WebElement billingadmindashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'billingadmindashboard-btn-5')]")
	private WebElement billingadmindashboardBtn5;

    public Client75BillingadmindashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client75BillingadmindashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client75BillingadmindashboardscreenScreen", "/offices/franchise/roles/billing_admin/dashboard");
    }
}

