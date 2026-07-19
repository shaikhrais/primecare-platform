package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic643FranchisesalesmanagerleadsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 643;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_manager_leads-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_manager_leads-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_manager_leads-content')]")
	private WebElement primaryContent;

    public Clinic643FranchisesalesmanagerleadsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic643FranchisesalesmanagerleadsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic643FranchisesalesmanagerleadsscreenScreen", "/offices/business_development/roles/franchise_sales_manager/leads");
    }
}
