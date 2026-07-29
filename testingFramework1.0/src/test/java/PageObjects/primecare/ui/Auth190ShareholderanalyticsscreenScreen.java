package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth190ShareholderanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 190;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shareholder_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shareholder_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shareholder_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shareholderanalytics-btn-3')]")
	private WebElement shareholderanalyticsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shareholderanalytics-btn-1')]")
	private WebElement shareholderanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shareholderanalytics-title')]")
	private WebElement shareholderanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shareholderanalytics-content')]")
	private WebElement shareholderanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shareholderanalytics-screen')]")
	private WebElement shareholderanalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shareholderanalytics-btn-2')]")
	private WebElement shareholderanalyticsBtn2;

    public Auth190ShareholderanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth190ShareholderanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth190ShareholderanalyticsscreenScreen", "/executive/shareholder-analytics");
    }
}

