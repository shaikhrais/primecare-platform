package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client52ShareholderdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 52;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shareholder_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shareholder_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'shareholder_dashboard-content')]")
	private WebElement primaryContent;

    public Client52ShareholderdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client52ShareholderdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client52ShareholderdashboardscreenScreen", "/offices/corporate/roles/shareholder/dashboard");
    }
}

