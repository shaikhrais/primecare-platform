package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Governance595ApihealthdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 595;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'api_health_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'api_health_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'api_health_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'apihealthdashboard-btn-2')]")
	private WebElement apihealthdashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'apihealthdashboard-btn-1')]")
	private WebElement apihealthdashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'apihealthdashboard-content')]")
	private WebElement apihealthdashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'apihealthdashboard-btn-3')]")
	private WebElement apihealthdashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'apihealthdashboard-screen')]")
	private WebElement apihealthdashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'apihealthdashboard-title')]")
	private WebElement apihealthdashboardTitle;

    public Governance595ApihealthdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Governance595ApihealthdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Governance595ApihealthdashboardscreenScreen", "/common/api-health-dashboard");
    }
}

