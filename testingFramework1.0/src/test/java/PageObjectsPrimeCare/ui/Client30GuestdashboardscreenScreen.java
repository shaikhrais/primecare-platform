package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client30GuestdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 30;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guest_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guest_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guest_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guestdashboard-content')]")
	private WebElement guestdashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guestdashboard-loading')]")
	private WebElement guestdashboardLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guestdashboard-btn-5')]")
	private WebElement guestdashboardBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guestdashboard-btn-4')]")
	private WebElement guestdashboardBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guestdashboard-btn-2')]")
	private WebElement guestdashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guestdashboard-screen')]")
	private WebElement guestdashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guestdashboard-title')]")
	private WebElement guestdashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guestdashboard-btn-3')]")
	private WebElement guestdashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'guestdashboard-btn-1')]")
	private WebElement guestdashboardBtn1;

    public Client30GuestdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client30GuestdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client30GuestdashboardscreenScreen", "/common/guest-dashboard");
    }
}
