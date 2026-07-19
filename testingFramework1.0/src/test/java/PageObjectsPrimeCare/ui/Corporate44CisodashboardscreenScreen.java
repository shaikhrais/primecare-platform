package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate44CisodashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 44;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ciso_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ciso_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ciso_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cisodashboard-content')]")
	private WebElement cisodashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cisodashboard-loading')]")
	private WebElement cisodashboardLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cisodashboard-btn-2')]")
	private WebElement cisodashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cisodashboard-btn-3')]")
	private WebElement cisodashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cisodashboard-btn-1')]")
	private WebElement cisodashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cisodashboard-title')]")
	private WebElement cisodashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'cisodashboard-screen')]")
	private WebElement cisodashboardScreen;

    public Corporate44CisodashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate44CisodashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate44CisodashboardscreenScreen", "/offices/corporate/roles/ciso/dashboard");
    }
}
