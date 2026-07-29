package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth148SocialworkeranalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 148;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'social_worker_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'social_worker_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'social_worker_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'socialworkeranalytics-content')]")
	private WebElement socialworkeranalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'socialworkeranalytics-btn-2')]")
	private WebElement socialworkeranalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'socialworkeranalytics-screen')]")
	private WebElement socialworkeranalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'socialworkeranalytics-title')]")
	private WebElement socialworkeranalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'socialworkeranalytics-btn-1')]")
	private WebElement socialworkeranalyticsBtn1;

    public Auth148SocialworkeranalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth148SocialworkeranalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth148SocialworkeranalyticsscreenScreen", "/offices/clinical/roles/social_worker/analytics");
    }
}

