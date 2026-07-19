package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic641FranchisesalesmanagerdiscoverycallsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 641;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_manager_discovery_calls-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_manager_discovery_calls-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_manager_discovery_calls-content')]")
	private WebElement primaryContent;

    public Clinic641FranchisesalesmanagerdiscoverycallsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic641FranchisesalesmanagerdiscoverycallsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic641FranchisesalesmanagerdiscoverycallsscreenScreen", "/offices/business_development/roles/franchise_sales_manager/discovery-calls");
    }
}
