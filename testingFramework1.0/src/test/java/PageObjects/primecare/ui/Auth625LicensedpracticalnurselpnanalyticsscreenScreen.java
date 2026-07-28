package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth625LicensedpracticalnurselpnanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 625;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'lpn_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'lpn_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'lpn_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'licensed practical nurse (lpn) analytics-btn-1')]")
	private WebElement licensedpracticalnurselpnanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'licensed practical nurse (lpn) analytics-screen')]")
	private WebElement licensedpracticalnurselpnanalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'licensed practical nurse (lpn) analytics-content')]")
	private WebElement licensedpracticalnurselpnanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'licensed practical nurse (lpn) analytics-title')]")
	private WebElement licensedpracticalnurselpnanalyticsTitle;

    public Auth625LicensedpracticalnurselpnanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth625LicensedpracticalnurselpnanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth625LicensedpracticalnurselpnanalyticsscreenScreen", "/rpn/lpn-analytics");
    }
}

