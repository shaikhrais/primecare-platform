package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client31InfrastructuredashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 31;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructure_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructure_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructure_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructuredashboard-btn-1')]")
	private WebElement infrastructuredashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructuredashboard-title')]")
	private WebElement infrastructuredashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructuredashboard-btn-3')]")
	private WebElement infrastructuredashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructuredashboard-btn-2')]")
	private WebElement infrastructuredashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructuredashboard-screen')]")
	private WebElement infrastructuredashboardScreen;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'infrastructuredashboard-content')]")
	private WebElement infrastructuredashboardContent;

    public Client31InfrastructuredashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client31InfrastructuredashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client31InfrastructuredashboardscreenScreen", "/common/infrastructure-dashboard");
    }
}
