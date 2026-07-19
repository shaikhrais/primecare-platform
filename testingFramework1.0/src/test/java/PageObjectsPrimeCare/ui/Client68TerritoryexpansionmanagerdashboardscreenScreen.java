package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client68TerritoryexpansionmanagerdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 68;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_expansion_manager_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_expansion_manager_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territory_expansion_manager_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territoryexpansionmanagerdashboard-content')]")
	private WebElement territoryexpansionmanagerdashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territoryexpansionmanagerdashboard-btn-1')]")
	private WebElement territoryexpansionmanagerdashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territoryexpansionmanagerdashboard-title')]")
	private WebElement territoryexpansionmanagerdashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territoryexpansionmanagerdashboard-btn-2')]")
	private WebElement territoryexpansionmanagerdashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'territoryexpansionmanagerdashboard-screen')]")
	private WebElement territoryexpansionmanagerdashboardScreen;

    public Client68TerritoryexpansionmanagerdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client68TerritoryexpansionmanagerdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client68TerritoryexpansionmanagerdashboardscreenScreen", "/offices/business_development/roles/territory_expansion_manager/dashboard");
    }
}
