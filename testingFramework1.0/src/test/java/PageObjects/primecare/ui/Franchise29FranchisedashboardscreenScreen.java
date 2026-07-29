package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Franchise29FranchisedashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 29;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchise_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisedashboard-content')]")
	private WebElement franchisedashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisedashboard-screen')]")
	private WebElement franchisedashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisedashboard-title')]")
	private WebElement franchisedashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisedashboard-btn-2')]")
	private WebElement franchisedashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisedashboard-btn-1')]")
	private WebElement franchisedashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'franchisedashboard-btn-3')]")
	private WebElement franchisedashboardBtn3;

    public Franchise29FranchisedashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Franchise29FranchisedashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Franchise29FranchisedashboardscreenScreen", "/common/franchise-dashboard");
    }
}

