package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client66RegionalmanagerusadashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 66;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_manager_usa_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_manager_usa_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_manager_usa_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalmanagerusadashboard-content')]")
	private WebElement regionalmanagerusadashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalmanagerusadashboard-btn-1')]")
	private WebElement regionalmanagerusadashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalmanagerusadashboard-btn-3')]")
	private WebElement regionalmanagerusadashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalmanagerusadashboard-screen')]")
	private WebElement regionalmanagerusadashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalmanagerusadashboard-title')]")
	private WebElement regionalmanagerusadashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalmanagerusadashboard-btn-2')]")
	private WebElement regionalmanagerusadashboardBtn2;

    public Client66RegionalmanagerusadashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client66RegionalmanagerusadashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client66RegionalmanagerusadashboardscreenScreen", "/offices/business_development/roles/regional_manager_usa/dashboard");
    }
}
