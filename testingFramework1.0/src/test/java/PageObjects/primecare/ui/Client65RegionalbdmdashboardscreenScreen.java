package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client65RegionalbdmdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 65;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_bdm_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_bdm_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_bdm_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalbdmdashboard-title')]")
	private WebElement regionalbdmdashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalbdmdashboard-screen')]")
	private WebElement regionalbdmdashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalbdmdashboard-btn-3')]")
	private WebElement regionalbdmdashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalbdmdashboard-btn-1')]")
	private WebElement regionalbdmdashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalbdmdashboard-content')]")
	private WebElement regionalbdmdashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regionalbdmdashboard-btn-2')]")
	private WebElement regionalbdmdashboardBtn2;

    public Client65RegionalbdmdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client65RegionalbdmdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client65RegionalbdmdashboardscreenScreen", "/offices/business_development/roles/regional_bdm/dashboard");
    }
}

