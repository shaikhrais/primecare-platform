package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth205GeneralmanageranalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 205;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'general_manager_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'general_manager_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'general_manager_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'generalmanageranalytics-btn-2')]")
	private WebElement generalmanageranalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'generalmanageranalytics-btn-3')]")
	private WebElement generalmanageranalyticsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'generalmanageranalytics-title')]")
	private WebElement generalmanageranalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'generalmanageranalytics-screen')]")
	private WebElement generalmanageranalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'generalmanageranalytics-content')]")
	private WebElement generalmanageranalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'generalmanageranalytics-btn-1')]")
	private WebElement generalmanageranalyticsBtn1;

    public Auth205GeneralmanageranalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth205GeneralmanageranalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth205GeneralmanageranalyticsscreenScreen", "/management/general-manager-analytics");
    }
}
