package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Franchise56FranchisesalesmanagerdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 56;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_manager_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_manager_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_manager_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisesalesmanagerdashboard-content')]")
	private WebElement franchisesalesmanagerdashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisesalesmanagerdashboard-btn-1')]")
	private WebElement franchisesalesmanagerdashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisesalesmanagerdashboard-btn-2')]")
	private WebElement franchisesalesmanagerdashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisesalesmanagerdashboard-title')]")
	private WebElement franchisesalesmanagerdashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisesalesmanagerdashboard-screen')]")
	private WebElement franchisesalesmanagerdashboardScreen;

    public Franchise56FranchisesalesmanagerdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Franchise56FranchisesalesmanagerdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Franchise56FranchisesalesmanagerdashboardscreenScreen", "/offices/business_development/roles/franchise_sales_manager/dashboard");
    }
}

