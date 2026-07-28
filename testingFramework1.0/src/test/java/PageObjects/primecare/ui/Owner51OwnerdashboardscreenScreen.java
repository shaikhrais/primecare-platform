package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Owner51OwnerdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 51;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'owner_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'owner_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'owner_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ownerdashboard-screen')]")
	private WebElement ownerdashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ownerdashboard-btn-2')]")
	private WebElement ownerdashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ownerdashboard-content')]")
	private WebElement ownerdashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ownerdashboard-title')]")
	private WebElement ownerdashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ownerdashboard-btn-3')]")
	private WebElement ownerdashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ownerdashboard-loading')]")
	private WebElement ownerdashboardLoading;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'ownerdashboard-btn-1')]")
	private WebElement ownerdashboardBtn1;

    public Owner51OwnerdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Owner51OwnerdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Owner51OwnerdashboardscreenScreen", "/offices/corporate/roles/owner/dashboard");
    }
}

