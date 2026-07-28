package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth187OwneranalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 187;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'owner_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'owner_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'owner_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'owneranalytics-btn-1')]")
	private WebElement owneranalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'owneranalytics-screen')]")
	private WebElement owneranalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'owneranalytics-title')]")
	private WebElement owneranalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'owneranalytics-content')]")
	private WebElement owneranalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'owneranalytics-btn-2')]")
	private WebElement owneranalyticsBtn2;

    public Auth187OwneranalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth187OwneranalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth187OwneranalyticsscreenScreen", "/executive/owner-analytics");
    }
}

