package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client63PartnershipmanagerdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 63;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnership_manager_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnership_manager_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnership_manager_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnershipmanagerdashboard-btn-2')]")
	private WebElement partnershipmanagerdashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnershipmanagerdashboard-content')]")
	private WebElement partnershipmanagerdashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnershipmanagerdashboard-title')]")
	private WebElement partnershipmanagerdashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnershipmanagerdashboard-screen')]")
	private WebElement partnershipmanagerdashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnershipmanagerdashboard-btn-3')]")
	private WebElement partnershipmanagerdashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'partnershipmanagerdashboard-btn-1')]")
	private WebElement partnershipmanagerdashboardBtn1;

    public Client63PartnershipmanagerdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client63PartnershipmanagerdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client63PartnershipmanagerdashboardscreenScreen", "/offices/business_development/roles/partnership_manager/dashboard");
    }
}

