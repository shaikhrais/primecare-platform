package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Corporate20ArchitectureplanningdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 20;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'architecture_planning_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'architecture_planning_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'architecture_planning_dashboard-content')]")
	private WebElement primaryContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'architectureplanningdashboard-btn-1')]")
	private WebElement architectureplanningdashboardBtn1;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'architectureplanningdashboard-btn-2')]")
	private WebElement architectureplanningdashboardBtn2;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'architectureplanningdashboard-content')]")
	private WebElement architectureplanningdashboardContent;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'architectureplanningdashboard-btn-3')]")
	private WebElement architectureplanningdashboardBtn3;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'architectureplanningdashboard-title')]")
	private WebElement architectureplanningdashboardTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'architectureplanningdashboard-screen')]")
	private WebElement architectureplanningdashboardScreen;

    public Corporate20ArchitectureplanningdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Corporate20ArchitectureplanningdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Corporate20ArchitectureplanningdashboardscreenScreen", "/common/architecture-planning-dashboard");
    }
}
