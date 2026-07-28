package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth163CfoanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 163;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfo_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfoanalytics-content')]")
	private WebElement cfoanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfoanalytics-title')]")
	private WebElement cfoanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfoanalytics-btn-1')]")
	private WebElement cfoanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfoanalytics-btn-2')]")
	private WebElement cfoanalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cfoanalytics-screen')]")
	private WebElement cfoanalyticsScreen;

    public Auth163CfoanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth163CfoanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth163CfoanalyticsscreenScreen", "/executive/cfo-analytics");
    }
}

