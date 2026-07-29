package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth99BusinessdevelopmentanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 99;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'business_development_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'business_development_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'business_development_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'businessdevelopmentanalytics-screen')]")
	private WebElement businessdevelopmentanalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'businessdevelopmentanalytics-btn-1')]")
	private WebElement businessdevelopmentanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'businessdevelopmentanalytics-content')]")
	private WebElement businessdevelopmentanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'businessdevelopmentanalytics-title')]")
	private WebElement businessdevelopmentanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'businessdevelopmentanalytics-btn-2')]")
	private WebElement businessdevelopmentanalyticsBtn2;

    public Auth99BusinessdevelopmentanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth99BusinessdevelopmentanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth99BusinessdevelopmentanalyticsscreenScreen", "/common/business-development-analytics");
    }
}

