package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client50LegaldashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 50;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legal_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legal_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legal_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legaldashboard-btn-1')]")
	private WebElement legaldashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legaldashboard-btn-2')]")
	private WebElement legaldashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legaldashboard-content')]")
	private WebElement legaldashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legaldashboard-title')]")
	private WebElement legaldashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legaldashboard-btn-3')]")
	private WebElement legaldashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legaldashboard-loading')]")
	private WebElement legaldashboardLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'legaldashboard-screen')]")
	private WebElement legaldashboardScreen;

    public Client50LegaldashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client50LegaldashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client50LegaldashboardscreenScreen", "/offices/corporate/roles/legal/dashboard");
    }
}
