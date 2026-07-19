package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Governance598RolecoveragedashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 598;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'role_coverage_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'role_coverage_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'role_coverage_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rolecoveragedashboard-title')]")
	private WebElement rolecoveragedashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rolecoveragedashboard-btn-1')]")
	private WebElement rolecoveragedashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rolecoveragedashboard-content')]")
	private WebElement rolecoveragedashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rolecoveragedashboard-btn-2')]")
	private WebElement rolecoveragedashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rolecoveragedashboard-btn-3')]")
	private WebElement rolecoveragedashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'rolecoveragedashboard-screen')]")
	private WebElement rolecoveragedashboardScreen;

    public Governance598RolecoveragedashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Governance598RolecoveragedashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Governance598RolecoveragedashboardscreenScreen", "/common/role-coverage-dashboard");
    }
}
