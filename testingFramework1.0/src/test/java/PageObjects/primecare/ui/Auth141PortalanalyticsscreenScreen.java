package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth141PortalanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 141;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portal_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portal_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portal_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portalanalytics-content')]")
	private WebElement portalanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portalanalytics-screen')]")
	private WebElement portalanalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portalanalytics-title')]")
	private WebElement portalanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portalanalytics-btn-2')]")
	private WebElement portalanalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portalanalytics-btn-3')]")
	private WebElement portalanalyticsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portalanalytics-btn-1')]")
	private WebElement portalanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portalanalytics-loading')]")
	private WebElement portalanalyticsLoading;

    public Auth141PortalanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth141PortalanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth141PortalanalyticsscreenScreen", "/common/portal-analytics");
    }
}

