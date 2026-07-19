package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client42TraininghubdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 42;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_hub_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_hub_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'training_hub_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'traininghubdashboard-content')]")
	private WebElement traininghubdashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'traininghubdashboard-screen')]")
	private WebElement traininghubdashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'traininghubdashboard-btn-1')]")
	private WebElement traininghubdashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'traininghubdashboard-btn-2')]")
	private WebElement traininghubdashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'traininghubdashboard-btn-3')]")
	private WebElement traininghubdashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'traininghubdashboard-title')]")
	private WebElement traininghubdashboardTitle;

    public Client42TraininghubdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client42TraininghubdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client42TraininghubdashboardscreenScreen", "/common/training-hub-dashboard");
    }
}
