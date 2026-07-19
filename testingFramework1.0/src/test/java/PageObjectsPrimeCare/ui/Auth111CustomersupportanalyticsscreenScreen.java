package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth111CustomersupportanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 111;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customer_support_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customer_support_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customer_support_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customersupportanalytics-title')]")
	private WebElement customersupportanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customersupportanalytics-btn-1')]")
	private WebElement customersupportanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customersupportanalytics-screen')]")
	private WebElement customersupportanalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customersupportanalytics-content')]")
	private WebElement customersupportanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'customersupportanalytics-btn-2')]")
	private WebElement customersupportanalyticsBtn2;

    public Auth111CustomersupportanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth111CustomersupportanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth111CustomersupportanalyticsscreenScreen", "/common/customer-support-analytics");
    }
}
