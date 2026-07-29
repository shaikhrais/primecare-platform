package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client22CaregiverdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 22;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiver_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiver_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiver_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiverdashboard-btn-2')]")
	private WebElement caregiverdashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiverdashboard-btn-3')]")
	private WebElement caregiverdashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiverdashboard-btn-1')]")
	private WebElement caregiverdashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiverdashboard-content')]")
	private WebElement caregiverdashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiverdashboard-screen')]")
	private WebElement caregiverdashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'caregiverdashboard-title')]")
	private WebElement caregiverdashboardTitle;

    public Client22CaregiverdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client22CaregiverdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client22CaregiverdashboardscreenScreen", "/offices/clinical/roles/caregiver/dashboard");
    }
}

