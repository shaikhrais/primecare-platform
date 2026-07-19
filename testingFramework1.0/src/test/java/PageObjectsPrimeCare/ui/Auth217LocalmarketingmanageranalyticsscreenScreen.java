package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth217LocalmarketingmanageranalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 217;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'local_marketing_manager_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'local_marketing_manager_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'local_marketing_manager_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'localmarketingmanageranalytics-btn-1')]")
	private WebElement localmarketingmanageranalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'localmarketingmanageranalytics-content')]")
	private WebElement localmarketingmanageranalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'localmarketingmanageranalytics-title')]")
	private WebElement localmarketingmanageranalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'localmarketingmanageranalytics-screen')]")
	private WebElement localmarketingmanageranalyticsScreen;

    public Auth217LocalmarketingmanageranalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth217LocalmarketingmanageranalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth217LocalmarketingmanageranalyticsscreenScreen", "/management/local-marketing-manager-analytics");
    }
}
