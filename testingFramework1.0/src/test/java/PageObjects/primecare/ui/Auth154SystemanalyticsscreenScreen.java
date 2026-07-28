package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth154SystemanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 154;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'system_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'system_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'system_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemanalytics-screen')]")
	private WebElement systemanalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemanalytics-btn-1')]")
	private WebElement systemanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemanalytics-content')]")
	private WebElement systemanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemanalytics-btn-2')]")
	private WebElement systemanalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemanalytics-title')]")
	private WebElement systemanalyticsTitle;

    public Auth154SystemanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth154SystemanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth154SystemanalyticsscreenScreen", "/common/system-analytics");
    }
}

