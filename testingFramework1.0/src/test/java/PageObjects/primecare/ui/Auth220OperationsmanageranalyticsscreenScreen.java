package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth220OperationsmanageranalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 220;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_manager_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_manager_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_manager_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operationsmanageranalytics-btn-2')]")
	private WebElement operationsmanageranalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operationsmanageranalytics-title')]")
	private WebElement operationsmanageranalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operationsmanageranalytics-screen')]")
	private WebElement operationsmanageranalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operationsmanageranalytics-btn-1')]")
	private WebElement operationsmanageranalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operationsmanageranalytics-content')]")
	private WebElement operationsmanageranalyticsContent;

    public Auth220OperationsmanageranalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth220OperationsmanageranalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth220OperationsmanageranalyticsscreenScreen", "/management/operations-manager-analytics");
    }
}

