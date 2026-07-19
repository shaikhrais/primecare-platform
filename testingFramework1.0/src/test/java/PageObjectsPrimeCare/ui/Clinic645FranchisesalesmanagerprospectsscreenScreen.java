package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic645FranchisesalesmanagerprospectsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 645;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_manager_prospects-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_manager_prospects-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_manager_prospects-content')]")
	private WebElement primaryContent;

    public Clinic645FranchisesalesmanagerprospectsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic645FranchisesalesmanagerprospectsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic645FranchisesalesmanagerprospectsscreenScreen", "/offices/business_development/roles/franchise_sales_manager/prospects");
    }
}
