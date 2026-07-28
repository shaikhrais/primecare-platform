package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client1272ScreenprogressdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 1272;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'screen_progress_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'screen_progress_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'screen_progress_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'screenprogressdashboard-total-screens')]")
	private WebElement screenprogressdashboardTotalScreens;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'screenprogressdashboard-blocked-screens')]")
	private WebElement screenprogressdashboardBlockedScreens;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'screenprogressdashboard-final-screens')]")
	private WebElement screenprogressdashboardFinalScreens;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'screenprogressdashboard-screen')]")
	private WebElement screenprogressdashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'screenprogressdashboard-refresh')]")
	private WebElement screenprogressdashboardRefresh;

    public Client1272ScreenprogressdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client1272ScreenprogressdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client1272ScreenprogressdashboardscreenScreen", "/management/screen-progress-dashboard");
    }
}

