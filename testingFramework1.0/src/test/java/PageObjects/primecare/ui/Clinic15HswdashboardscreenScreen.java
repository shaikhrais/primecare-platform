package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic15HswdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 15;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hsw_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hsw_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hsw_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hswdashboard-btn-2')]")
	private WebElement hswdashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hswdashboard-title')]")
	private WebElement hswdashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hswdashboard-content')]")
	private WebElement hswdashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hswdashboard-btn-1')]")
	private WebElement hswdashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hswdashboard-loading')]")
	private WebElement hswdashboardLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hswdashboard-btn-3')]")
	private WebElement hswdashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'hswdashboard-screen')]")
	private WebElement hswdashboardScreen;

    public Clinic15HswdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic15HswdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic15HswdashboardscreenScreen", "/clinical/hsw-dashboard");
    }
}

