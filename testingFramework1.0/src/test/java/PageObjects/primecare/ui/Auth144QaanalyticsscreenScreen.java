package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth144QaanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 144;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qa_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qa_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qa_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qaanalytics-screen')]")
	private WebElement qaanalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qaanalytics-btn-2')]")
	private WebElement qaanalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qaanalytics-content')]")
	private WebElement qaanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qaanalytics-btn-1')]")
	private WebElement qaanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'qaanalytics-title')]")
	private WebElement qaanalyticsTitle;

    public Auth144QaanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth144QaanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth144QaanalyticsscreenScreen", "/common/qa-analytics");
    }
}

