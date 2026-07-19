package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth617PremiumconciergecarecoordinatoranalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 617;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'premium_concierge_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'premium_concierge_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'premium_concierge_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'premium concierge care coordinator analytics-title')]")
	private WebElement premiumconciergecarecoordinatoranalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'premium concierge care coordinator analytics-screen')]")
	private WebElement premiumconciergecarecoordinatoranalyticsScreen;

    public Auth617PremiumconciergecarecoordinatoranalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth617PremiumconciergecarecoordinatoranalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth617PremiumconciergecarecoordinatoranalyticsscreenScreen", "/premium/premium-concierge-analytics");
    }
}
