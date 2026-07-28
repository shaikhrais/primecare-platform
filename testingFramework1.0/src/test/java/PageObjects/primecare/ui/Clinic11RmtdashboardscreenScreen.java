package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic11RmtdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 11;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmt_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmt_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmt_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtdashboard-screen')]")
	private WebElement rmtdashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtdashboard-btn-3')]")
	private WebElement rmtdashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtdashboard-loading')]")
	private WebElement rmtdashboardLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtdashboard-btn-3-${apt.id}')]")
	private WebElement rmtdashboardBtn3Aptid;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtdashboard-btn-4-${apt.id}')]")
	private WebElement rmtdashboardBtn4Aptid;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtdashboard-btn-2')]")
	private WebElement rmtdashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtdashboard-btn-1')]")
	private WebElement rmtdashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rmtdashboard-title')]")
	private WebElement rmtdashboardTitle;

    public Clinic11RmtdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic11RmtdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic11RmtdashboardscreenScreen", "/offices/clinical/roles/rmt/dashboard");
    }
}

