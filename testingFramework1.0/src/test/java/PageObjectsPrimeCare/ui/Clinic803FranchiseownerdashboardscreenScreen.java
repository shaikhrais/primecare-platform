package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic803FranchiseownerdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 803;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_owner_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_owner_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_owner_dashboard-content')]")
	private WebElement primaryContent;

    public Clinic803FranchiseownerdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic803FranchiseownerdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic803FranchiseownerdashboardscreenScreen", "/offices/franchise/roles/franchise_owner/dashboard");
    }
}
