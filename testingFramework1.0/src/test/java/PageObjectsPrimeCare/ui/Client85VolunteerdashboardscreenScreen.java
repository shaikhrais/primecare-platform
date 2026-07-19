package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client85VolunteerdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 85;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteer_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteer_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteer_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteerdashboard-btn-3')]")
	private WebElement volunteerdashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteerdashboard-title')]")
	private WebElement volunteerdashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteerdashboard-screen')]")
	private WebElement volunteerdashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteerdashboard-btn-1')]")
	private WebElement volunteerdashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteerdashboard-btn-2')]")
	private WebElement volunteerdashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteerdashboard-btn-5')]")
	private WebElement volunteerdashboardBtn5;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteerdashboard-content')]")
	private WebElement volunteerdashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'volunteerdashboard-btn-4')]")
	private WebElement volunteerdashboardBtn4;

    public Client85VolunteerdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client85VolunteerdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client85VolunteerdashboardscreenScreen", "/staff/volunteer-dashboard");
    }
}
