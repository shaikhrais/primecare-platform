package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth120FranchiseanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 120;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseanalytics-content')]")
	private WebElement franchiseanalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseanalytics-title')]")
	private WebElement franchiseanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseanalytics-btn-1')]")
	private WebElement franchiseanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseanalytics-btn-2')]")
	private WebElement franchiseanalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchiseanalytics-screen')]")
	private WebElement franchiseanalyticsScreen;

    public Auth120FranchiseanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth120FranchiseanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth120FranchiseanalyticsscreenScreen", "/common/franchise-analytics");
    }
}

