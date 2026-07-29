package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic644FranchisesalesmanagerproposalsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 644;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_manager_proposals-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_manager_proposals-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_manager_proposals-content')]")
	private WebElement primaryContent;

    public Clinic644FranchisesalesmanagerproposalsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic644FranchisesalesmanagerproposalsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic644FranchisesalesmanagerproposalsscreenScreen", "/offices/business_development/roles/franchise_sales_manager/proposals");
    }
}

