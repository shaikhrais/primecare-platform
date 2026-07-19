package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth86RmtanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 86;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmt_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmt_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmt_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtanalytics-btn-1')]")
	private WebElement rmtanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtanalytics-title')]")
	private WebElement rmtanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtanalytics-screen')]")
	private WebElement rmtanalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtanalytics-content')]")
	private WebElement rmtanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtanalytics-btn-2')]")
	private WebElement rmtanalyticsBtn2;

    public Auth86RmtanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth86RmtanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth86RmtanalyticsscreenScreen", "/offices/clinical/roles/rmt/analytics");
    }
}
