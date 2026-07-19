package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic810MarketingmanagerdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 810;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'marketing_manager_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'marketing_manager_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'marketing_manager_dashboard-content')]")
	private WebElement primaryContent;

    public Clinic810MarketingmanagerdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic810MarketingmanagerdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic810MarketingmanagerdashboardscreenScreen", "/offices/franchise/roles/marketing_manager/dashboard");
    }
}
