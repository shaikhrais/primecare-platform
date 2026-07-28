package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth132OfficeanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 132;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'office_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'office_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'office_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'officeanalytics-btn-2')]")
	private WebElement officeanalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'officeanalytics-content')]")
	private WebElement officeanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'officeanalytics-screen')]")
	private WebElement officeanalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'officeanalytics-title')]")
	private WebElement officeanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'officeanalytics-btn-1')]")
	private WebElement officeanalyticsBtn1;

    public Auth132OfficeanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth132OfficeanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth132OfficeanalyticsscreenScreen", "/common/office-analytics");
    }
}

