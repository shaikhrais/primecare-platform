package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth151SupportanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 151;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'support_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'support_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'support_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'supportanalytics-screen')]")
	private WebElement supportanalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'supportanalytics-title')]")
	private WebElement supportanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'supportanalytics-btn-2')]")
	private WebElement supportanalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'supportanalytics-btn-1')]")
	private WebElement supportanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'supportanalytics-content')]")
	private WebElement supportanalyticsContent;

    public Auth151SupportanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth151SupportanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth151SupportanalyticsscreenScreen", "/common/support-analytics");
    }
}

