package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth202FranchisesalesmanageranalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 202;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_manager_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_manager_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_manager_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisesalesmanageranalytics-title')]")
	private WebElement franchisesalesmanageranalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisesalesmanageranalytics-content')]")
	private WebElement franchisesalesmanageranalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisesalesmanageranalytics-screen')]")
	private WebElement franchisesalesmanageranalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisesalesmanageranalytics-btn-1')]")
	private WebElement franchisesalesmanageranalyticsBtn1;

    public Auth202FranchisesalesmanageranalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth202FranchisesalesmanageranalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth202FranchisesalesmanageranalyticsscreenScreen", "/management/franchise-sales-manager-analytics");
    }
}
