package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client39SupportdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 39;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'support_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'support_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'support_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'supportdashboard-btn-1')]")
	private WebElement supportdashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'supportdashboard-btn-5')]")
	private WebElement supportdashboardBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'supportdashboard-loading')]")
	private WebElement supportdashboardLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'supportdashboard-content')]")
	private WebElement supportdashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'supportdashboard-btn-4')]")
	private WebElement supportdashboardBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'supportdashboard-title')]")
	private WebElement supportdashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'supportdashboard-btn-2')]")
	private WebElement supportdashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'supportdashboard-btn-3')]")
	private WebElement supportdashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'supportdashboard-screen')]")
	private WebElement supportdashboardScreen;

    public Client39SupportdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client39SupportdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client39SupportdashboardscreenScreen", "/common/support-dashboard");
    }
}
