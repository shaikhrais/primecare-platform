package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth615FranchisesalesmanageranalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 615;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_sales_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise sales manager analytics-btn-1')]")
	private WebElement franchisesalesmanageranalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise sales manager analytics-screen')]")
	private WebElement franchisesalesmanageranalyticsScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise sales manager analytics-content')]")
	private WebElement franchisesalesmanageranalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise sales manager analytics-title')]")
	private WebElement franchisesalesmanageranalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise sales manager analytics-btn-2')]")
	private WebElement franchisesalesmanageranalyticsBtn2;

    public Auth615FranchisesalesmanageranalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth615FranchisesalesmanageranalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth615FranchisesalesmanageranalyticsscreenScreen", "/executive/franchise-sales-analytics");
    }
}

