package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client69TerritorysalesmanagerdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 69;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_sales_manager_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_sales_manager_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_sales_manager_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territorysalesmanagerdashboard-title')]")
	private WebElement territorysalesmanagerdashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territorysalesmanagerdashboard-btn-2')]")
	private WebElement territorysalesmanagerdashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territorysalesmanagerdashboard-btn-1')]")
	private WebElement territorysalesmanagerdashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territorysalesmanagerdashboard-screen')]")
	private WebElement territorysalesmanagerdashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territorysalesmanagerdashboard-content')]")
	private WebElement territorysalesmanagerdashboardContent;

    public Client69TerritorysalesmanagerdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client69TerritorysalesmanagerdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client69TerritorysalesmanagerdashboardscreenScreen", "/offices/marketing/roles/territory_sales_manager/dashboard");
    }
}
