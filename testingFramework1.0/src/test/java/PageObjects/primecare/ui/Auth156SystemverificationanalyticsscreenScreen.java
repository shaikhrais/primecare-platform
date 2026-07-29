package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth156SystemverificationanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 156;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'system_verification_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'system_verification_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'system_verification_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemverificationanalytics-content')]")
	private WebElement systemverificationanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemverificationanalytics-btn-2')]")
	private WebElement systemverificationanalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemverificationanalytics-title')]")
	private WebElement systemverificationanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemverificationanalytics-screen')]")
	private WebElement systemverificationanalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemverificationanalytics-btn-1')]")
	private WebElement systemverificationanalyticsBtn1;

    public Auth156SystemverificationanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth156SystemverificationanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth156SystemverificationanalyticsscreenScreen", "/common/system-verification-analytics");
    }
}

