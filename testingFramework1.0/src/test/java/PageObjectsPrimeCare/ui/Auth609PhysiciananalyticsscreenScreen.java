package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth609PhysiciananalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 609;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physician_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physician_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physician_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physician analytics-title')]")
	private WebElement physiciananalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physician analytics-btn-1')]")
	private WebElement physiciananalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physician analytics-screen')]")
	private WebElement physiciananalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physician analytics-content')]")
	private WebElement physiciananalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physician analytics-loading')]")
	private WebElement physiciananalyticsLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physician analytics-btn-2')]")
	private WebElement physiciananalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'physician analytics-btn-3')]")
	private WebElement physiciananalyticsBtn3;

    public Auth609PhysiciananalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth609PhysiciananalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth609PhysiciananalyticsscreenScreen", "/clinical/physician-analytics");
    }
}
