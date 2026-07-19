package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client57GeneralmanagerdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 57;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'general_manager_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'general_manager_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'general_manager_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'generalmanagerdashboard-btn-4')]")
	private WebElement generalmanagerdashboardBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'generalmanagerdashboard-screen')]")
	private WebElement generalmanagerdashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'generalmanagerdashboard-btn-3')]")
	private WebElement generalmanagerdashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'generalmanagerdashboard-btn-2')]")
	private WebElement generalmanagerdashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'generalmanagerdashboard-btn-5')]")
	private WebElement generalmanagerdashboardBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'generalmanagerdashboard-content')]")
	private WebElement generalmanagerdashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'generalmanagerdashboard-btn-1')]")
	private WebElement generalmanagerdashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'generalmanagerdashboard-title')]")
	private WebElement generalmanagerdashboardTitle;

    public Client57GeneralmanagerdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client57GeneralmanagerdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client57GeneralmanagerdashboardscreenScreen", "/offices/business_development/roles/general_manager/dashboard");
    }
}
