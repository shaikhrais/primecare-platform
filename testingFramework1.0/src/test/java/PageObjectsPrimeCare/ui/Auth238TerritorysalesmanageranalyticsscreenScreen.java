package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Auth238TerritorysalesmanageranalyticsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 238;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_sales_manager_analytics-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_sales_manager_analytics-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_sales_manager_analytics-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territorysalesmanageranalytics-content')]")
	private WebElement territorysalesmanageranalyticsContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territorysalesmanageranalytics-title')]")
	private WebElement territorysalesmanageranalyticsTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territorysalesmanageranalytics-btn-1')]")
	private WebElement territorysalesmanageranalyticsBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territorysalesmanageranalytics-screen')]")
	private WebElement territorysalesmanageranalyticsScreen;

    public Auth238TerritorysalesmanageranalyticsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Auth238TerritorysalesmanageranalyticsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Auth238TerritorysalesmanageranalyticsscreenScreen", "/management/territory-sales-manager-analytics");
    }
}
