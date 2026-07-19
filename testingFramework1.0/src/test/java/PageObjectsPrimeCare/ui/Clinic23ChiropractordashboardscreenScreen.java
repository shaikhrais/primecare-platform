package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic23ChiropractordashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 23;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractor_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractor_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractor_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractordashboard-btn-1')]")
	private WebElement chiropractordashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractordashboard-screen')]")
	private WebElement chiropractordashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractordashboard-loading')]")
	private WebElement chiropractordashboardLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractordashboard-title')]")
	private WebElement chiropractordashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractordashboard-btn-3')]")
	private WebElement chiropractordashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'chiropractordashboard-btn-2')]")
	private WebElement chiropractordashboardBtn2;

    public Clinic23ChiropractordashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic23ChiropractordashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic23ChiropractordashboardscreenScreen", "/offices/clinical/roles/chiropractor/dashboard");
    }
}
