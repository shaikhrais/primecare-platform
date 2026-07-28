package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth619VipclientmanageranalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 619;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vip_manager_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vip_manager_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vip_manager_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vip client manager analytics-btn-1')]")
	private WebElement vipclientmanageranalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vip client manager analytics-screen')]")
	private WebElement vipclientmanageranalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vip client manager analytics-content')]")
	private WebElement vipclientmanageranalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vip client manager analytics-btn-3')]")
	private WebElement vipclientmanageranalyticsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vip client manager analytics-title')]")
	private WebElement vipclientmanageranalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vip client manager analytics-btn-2')]")
	private WebElement vipclientmanageranalyticsBtn2;

    public Auth619VipclientmanageranalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth619VipclientmanageranalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth619VipclientmanageranalyticsscreenScreen", "/executive/vip-manager-analytics");
    }
}

