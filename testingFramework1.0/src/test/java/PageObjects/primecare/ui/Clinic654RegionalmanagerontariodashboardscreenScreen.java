package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic654RegionalmanagerontariodashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 654;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_manager_ontario_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_manager_ontario_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'regional_manager_ontario_dashboard-content')]")
	private WebElement primaryContent;

    public Clinic654RegionalmanagerontariodashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic654RegionalmanagerontariodashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic654RegionalmanagerontariodashboardscreenScreen", "/offices/business_development/roles/regional_manager_ontario/dashboard");
    }
}

