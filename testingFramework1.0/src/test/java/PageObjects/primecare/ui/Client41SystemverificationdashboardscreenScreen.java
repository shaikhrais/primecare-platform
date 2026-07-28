package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client41SystemverificationdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 41;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'system_verification_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'system_verification_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'system_verification_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemverificationdashboard-screen')]")
	private WebElement systemverificationdashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemverificationdashboard-content')]")
	private WebElement systemverificationdashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemverificationdashboard-btn-3')]")
	private WebElement systemverificationdashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemverificationdashboard-btn-1')]")
	private WebElement systemverificationdashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemverificationdashboard-btn-2')]")
	private WebElement systemverificationdashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'systemverificationdashboard-title')]")
	private WebElement systemverificationdashboardTitle;

    public Client41SystemverificationdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client41SystemverificationdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client41SystemverificationdashboardscreenScreen", "/common/system-verification-dashboard");
    }
}

