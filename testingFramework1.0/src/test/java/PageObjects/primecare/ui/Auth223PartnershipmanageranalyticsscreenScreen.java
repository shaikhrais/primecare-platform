package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth223PartnershipmanageranalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 223;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnership_manager_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnership_manager_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnership_manager_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnershipmanageranalytics-content')]")
	private WebElement partnershipmanageranalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnershipmanageranalytics-btn-1')]")
	private WebElement partnershipmanageranalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnershipmanageranalytics-title')]")
	private WebElement partnershipmanageranalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnershipmanageranalytics-screen')]")
	private WebElement partnershipmanageranalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnershipmanageranalytics-btn-2')]")
	private WebElement partnershipmanageranalyticsBtn2;

    public Auth223PartnershipmanageranalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth223PartnershipmanageranalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth223PartnershipmanageranalyticsscreenScreen", "/management/partnership-manager-analytics");
    }
}

