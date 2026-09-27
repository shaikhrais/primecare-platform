package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth123GuestanalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 123;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guest_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guest_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guest_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guestanalytics-screen')]")
	private WebElement guestanalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guestanalytics-btn-1')]")
	private WebElement guestanalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guestanalytics-btn-3')]")
	private WebElement guestanalyticsBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guestanalytics-title')]")
	private WebElement guestanalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guestanalytics-btn-2')]")
	private WebElement guestanalyticsBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guestanalytics-content')]")
	private WebElement guestanalyticsContent;

    public Auth123GuestanalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth123GuestanalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth123GuestanalyticsscreenScreen", "/common/guest-analytics");
    }
}

