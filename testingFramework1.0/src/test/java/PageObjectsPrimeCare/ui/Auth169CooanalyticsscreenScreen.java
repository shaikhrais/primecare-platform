package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth169CooanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 169;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'coo_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cooanalytics-title')]")
	private WebElement cooanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cooanalytics-btn-1')]")
	private WebElement cooanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cooanalytics-btn-2')]")
	private WebElement cooanalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cooanalytics-screen')]")
	private WebElement cooanalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cooanalytics-content')]")
	private WebElement cooanalyticsContent;

    public Auth169CooanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth169CooanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth169CooanalyticsscreenScreen", "/executive/coo-analytics");
    }
}
