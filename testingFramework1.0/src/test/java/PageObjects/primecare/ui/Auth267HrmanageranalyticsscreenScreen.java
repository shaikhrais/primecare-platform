package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth267HrmanageranalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 267;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_manager_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_manager_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hr_manager_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrmanageranalytics-title')]")
	private WebElement hrmanageranalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrmanageranalytics-btn-3')]")
	private WebElement hrmanageranalyticsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrmanageranalytics-screen')]")
	private WebElement hrmanageranalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrmanageranalytics-btn-1')]")
	private WebElement hrmanageranalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrmanageranalytics-btn-2')]")
	private WebElement hrmanageranalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hrmanageranalytics-content')]")
	private WebElement hrmanageranalyticsContent;

    public Auth267HrmanageranalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth267HrmanageranalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth267HrmanageranalyticsscreenScreen", "/staff/hr-manager-analytics");
    }
}

