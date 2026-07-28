package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth229RegionalmanagerusaanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 229;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_manager_usa_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_manager_usa_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_manager_usa_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalmanagerusaanalytics-screen')]")
	private WebElement regionalmanagerusaanalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalmanagerusaanalytics-btn-2')]")
	private WebElement regionalmanagerusaanalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalmanagerusaanalytics-content')]")
	private WebElement regionalmanagerusaanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalmanagerusaanalytics-btn-1')]")
	private WebElement regionalmanagerusaanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalmanagerusaanalytics-title')]")
	private WebElement regionalmanagerusaanalyticsTitle;

    public Auth229RegionalmanagerusaanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth229RegionalmanagerusaanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth229RegionalmanagerusaanalyticsscreenScreen", "/management/regional-manager-usa-analytics");
    }
}

