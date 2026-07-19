package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic38SocialworkerdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 38;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'social_worker_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'social_worker_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'social_worker_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'socialworkerdashboard-btn-1')]")
	private WebElement socialworkerdashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'socialworkerdashboard-screen')]")
	private WebElement socialworkerdashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'socialworkerdashboard-btn-2')]")
	private WebElement socialworkerdashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'socialworkerdashboard-title')]")
	private WebElement socialworkerdashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'socialworkerdashboard-loading')]")
	private WebElement socialworkerdashboardLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'socialworkerdashboard-btn-3')]")
	private WebElement socialworkerdashboardBtn3;

    public Clinic38SocialworkerdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic38SocialworkerdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic38SocialworkerdashboardscreenScreen", "/offices/clinical/roles/social_worker/dashboard");
    }
}
