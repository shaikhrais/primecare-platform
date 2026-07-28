package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic646FranchisesalesmanagerreportsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 646;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_manager_reports-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_manager_reports-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_manager_reports-content')]")
	private WebElement primaryContent;

    public Clinic646FranchisesalesmanagerreportsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic646FranchisesalesmanagerreportsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic646FranchisesalesmanagerreportsscreenScreen", "/offices/business_development/roles/franchise_sales_manager/reports");
    }
}

