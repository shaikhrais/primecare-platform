package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic72RndashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 72;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rn_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rndashboard-btn-2')]")
	private WebElement rndashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rndashboard-title')]")
	private WebElement rndashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rndashboard-loading')]")
	private WebElement rndashboardLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rndashboard-btn-3')]")
	private WebElement rndashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rndashboard-screen')]")
	private WebElement rndashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rndashboard-btn-1')]")
	private WebElement rndashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rndashboard-content')]")
	private WebElement rndashboardContent;

    public Clinic72RndashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic72RndashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic72RndashboardscreenScreen", "/offices/clinical/roles/rn/dashboard");
    }
}

