package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth172CtoanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 172;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cto_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ctoanalytics-content')]")
	private WebElement ctoanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ctoanalytics-btn-2')]")
	private WebElement ctoanalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ctoanalytics-btn-1')]")
	private WebElement ctoanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ctoanalytics-title')]")
	private WebElement ctoanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ctoanalytics-screen')]")
	private WebElement ctoanalyticsScreen;

    public Auth172CtoanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth172CtoanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth172CtoanalyticsscreenScreen", "/executive/cto-analytics");
    }
}
