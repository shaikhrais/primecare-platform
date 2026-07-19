package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth166CisoanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 166;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ciso_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ciso_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ciso_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cisoanalytics-title')]")
	private WebElement cisoanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cisoanalytics-loading')]")
	private WebElement cisoanalyticsLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cisoanalytics-content')]")
	private WebElement cisoanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cisoanalytics-btn-2')]")
	private WebElement cisoanalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cisoanalytics-btn-1')]")
	private WebElement cisoanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cisoanalytics-btn-3')]")
	private WebElement cisoanalyticsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cisoanalytics-screen')]")
	private WebElement cisoanalyticsScreen;

    public Auth166CisoanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth166CisoanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth166CisoanalyticsscreenScreen", "/executive/ciso-analytics");
    }
}
