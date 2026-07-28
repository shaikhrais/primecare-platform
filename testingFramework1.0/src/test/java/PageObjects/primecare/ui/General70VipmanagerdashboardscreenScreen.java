package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class General70VipmanagerdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 70;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vip_manager_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vip_manager_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vip_manager_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vipmanagerdashboard-title')]")
	private WebElement vipmanagerdashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vipmanagerdashboard-btn-2')]")
	private WebElement vipmanagerdashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vipmanagerdashboard-screen')]")
	private WebElement vipmanagerdashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vipmanagerdashboard-content')]")
	private WebElement vipmanagerdashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vipmanagerdashboard-btn-1')]")
	private WebElement vipmanagerdashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'vipmanagerdashboard-btn-3')]")
	private WebElement vipmanagerdashboardBtn3;

    public General70VipmanagerdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public General70VipmanagerdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "General70VipmanagerdashboardscreenScreen", "/management/vip-manager-dashboard");
    }
}

