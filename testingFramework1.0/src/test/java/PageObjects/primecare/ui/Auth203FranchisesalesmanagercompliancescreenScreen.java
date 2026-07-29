package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth203FranchisesalesmanagercompliancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 203;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_manager_compliance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_manager_compliance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_manager_compliance-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisesalesmanagercompliance-btn-1')]")
	private WebElement franchisesalesmanagercomplianceBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisesalesmanagercompliance-screen')]")
	private WebElement franchisesalesmanagercomplianceScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisesalesmanagercompliance-content')]")
	private WebElement franchisesalesmanagercomplianceContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisesalesmanagercompliance-btn-2')]")
	private WebElement franchisesalesmanagercomplianceBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisesalesmanagercompliance-title')]")
	private WebElement franchisesalesmanagercomplianceTitle;

    public Auth203FranchisesalesmanagercompliancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth203FranchisesalesmanagercompliancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth203FranchisesalesmanagercompliancescreenScreen", "/management/franchise-sales-manager-compliance");
    }
}

