package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client81ReceptionistdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 81;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionist_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionist_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionist_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionistdashboard-title')]")
	private WebElement receptionistdashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionistdashboard-btn-3')]")
	private WebElement receptionistdashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionistdashboard-btn-4')]")
	private WebElement receptionistdashboardBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionistdashboard-btn-2')]")
	private WebElement receptionistdashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionistdashboard-btn-1')]")
	private WebElement receptionistdashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionistdashboard-btn-5')]")
	private WebElement receptionistdashboardBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionistdashboard-content')]")
	private WebElement receptionistdashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'receptionistdashboard-screen')]")
	private WebElement receptionistdashboardScreen;

    public Client81ReceptionistdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client81ReceptionistdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client81ReceptionistdashboardscreenScreen", "/staff/receptionist-dashboard");
    }
}

