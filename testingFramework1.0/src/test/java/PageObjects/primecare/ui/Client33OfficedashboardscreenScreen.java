package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client33OfficedashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 33;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'office_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'office_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'office_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'officedashboard-btn-1')]")
	private WebElement officedashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'officedashboard-btn-3')]")
	private WebElement officedashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'officedashboard-btn-2')]")
	private WebElement officedashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'officedashboard-content')]")
	private WebElement officedashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'officedashboard-screen')]")
	private WebElement officedashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'officedashboard-title')]")
	private WebElement officedashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'officedashboard-loading')]")
	private WebElement officedashboardLoading;

    public Client33OfficedashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client33OfficedashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client33OfficedashboardscreenScreen", "/common/office-dashboard");
    }
}

