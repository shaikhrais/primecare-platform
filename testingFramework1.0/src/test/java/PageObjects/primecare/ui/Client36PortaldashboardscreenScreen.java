package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client36PortaldashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 36;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portal_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portal_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portal_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portaldashboard-btn-2')]")
	private WebElement portaldashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portaldashboard-screen')]")
	private WebElement portaldashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portaldashboard-btn-4')]")
	private WebElement portaldashboardBtn4;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portaldashboard-loading')]")
	private WebElement portaldashboardLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portaldashboard-title')]")
	private WebElement portaldashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portaldashboard-content')]")
	private WebElement portaldashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portaldashboard-btn-3')]")
	private WebElement portaldashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portaldashboard-btn-1')]")
	private WebElement portaldashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'portaldashboard-btn-5')]")
	private WebElement portaldashboardBtn5;

    public Client36PortaldashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client36PortaldashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client36PortaldashboardscreenScreen", "/common/portal-dashboard");
    }
}

