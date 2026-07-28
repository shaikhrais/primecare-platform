package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client67ScrummasterdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 67;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrum_master_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrum_master_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrum_master_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrummasterdashboard-btn-2')]")
	private WebElement scrummasterdashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrummasterdashboard-content')]")
	private WebElement scrummasterdashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrummasterdashboard-btn-1')]")
	private WebElement scrummasterdashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrummasterdashboard-btn-3')]")
	private WebElement scrummasterdashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrummasterdashboard-title')]")
	private WebElement scrummasterdashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'scrummasterdashboard-screen')]")
	private WebElement scrummasterdashboardScreen;

    public Client67ScrummasterdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client67ScrummasterdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client67ScrummasterdashboardscreenScreen", "/management/scrum-master-dashboard");
    }
}

