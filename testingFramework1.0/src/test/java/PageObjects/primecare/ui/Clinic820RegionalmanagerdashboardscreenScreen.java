package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic820RegionalmanagerdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 820;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_manager_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_manager_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_manager_dashboard-content')]")
	private WebElement primaryContent;

    public Clinic820RegionalmanagerdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic820RegionalmanagerdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic820RegionalmanagerdashboardscreenScreen", "/offices/franchise/roles/regional_manager/dashboard");
    }
}

