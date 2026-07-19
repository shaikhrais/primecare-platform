package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Marketing61LocalmarketingmanagerdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 61;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'local_marketing_manager_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'local_marketing_manager_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'local_marketing_manager_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'localmarketingmanagerdashboard-title')]")
	private WebElement localmarketingmanagerdashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'localmarketingmanagerdashboard-screen')]")
	private WebElement localmarketingmanagerdashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'localmarketingmanagerdashboard-content')]")
	private WebElement localmarketingmanagerdashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'localmarketingmanagerdashboard-btn-2')]")
	private WebElement localmarketingmanagerdashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'localmarketingmanagerdashboard-btn-1')]")
	private WebElement localmarketingmanagerdashboardBtn1;

    public Marketing61LocalmarketingmanagerdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Marketing61LocalmarketingmanagerdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Marketing61LocalmarketingmanagerdashboardscreenScreen", "/offices/marketing/roles/local_marketing_manager/dashboard");
    }
}
