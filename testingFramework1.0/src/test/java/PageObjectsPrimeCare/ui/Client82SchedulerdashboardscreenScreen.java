package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client82SchedulerdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 82;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scheduler_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerdashboard-screen')]")
	private WebElement schedulerdashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerdashboard-btn-5')]")
	private WebElement schedulerdashboardBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerdashboard-btn-1')]")
	private WebElement schedulerdashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerdashboard-title')]")
	private WebElement schedulerdashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerdashboard-content')]")
	private WebElement schedulerdashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerdashboard-btn-4')]")
	private WebElement schedulerdashboardBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerdashboard-btn-2')]")
	private WebElement schedulerdashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'schedulerdashboard-btn-3')]")
	private WebElement schedulerdashboardBtn3;

    public Client82SchedulerdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client82SchedulerdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client82SchedulerdashboardscreenScreen", "/offices/franchise/roles/scheduler/dashboard");
    }
}
