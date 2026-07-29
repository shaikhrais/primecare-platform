package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic640FranchisesalesmanagercontractsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 640;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_manager_contracts-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_manager_contracts-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_manager_contracts-content')]")
	private WebElement primaryContent;

    public Clinic640FranchisesalesmanagercontractsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic640FranchisesalesmanagercontractsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic640FranchisesalesmanagercontractsscreenScreen", "/offices/business_development/roles/franchise_sales_manager/contracts");
    }
}

