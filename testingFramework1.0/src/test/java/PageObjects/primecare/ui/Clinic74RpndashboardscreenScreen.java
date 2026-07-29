package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic74RpndashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 74;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpn_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpndashboard-screen')]")
	private WebElement rpndashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpndashboard-btn-2')]")
	private WebElement rpndashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpndashboard-loading')]")
	private WebElement rpndashboardLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpndashboard-btn-3')]")
	private WebElement rpndashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpndashboard-title')]")
	private WebElement rpndashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpndashboard-btn-1')]")
	private WebElement rpndashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rpndashboard-content')]")
	private WebElement rpndashboardContent;

    public Clinic74RpndashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic74RpndashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic74RpndashboardscreenScreen", "/offices/clinical/roles/rpn/dashboard");
    }
}

