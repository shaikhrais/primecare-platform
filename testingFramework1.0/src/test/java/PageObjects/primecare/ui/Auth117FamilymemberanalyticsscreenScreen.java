package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth117FamilymemberanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 117;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_member_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_member_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'family_member_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'familymemberanalytics-screen')]")
	private WebElement familymemberanalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'familymemberanalytics-btn-2')]")
	private WebElement familymemberanalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'familymemberanalytics-btn-1')]")
	private WebElement familymemberanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'familymemberanalytics-title')]")
	private WebElement familymemberanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'familymemberanalytics-content')]")
	private WebElement familymemberanalyticsContent;

    public Auth117FamilymemberanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth117FamilymemberanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth117FamilymemberanalyticsscreenScreen", "/common/family-member-analytics");
    }
}

