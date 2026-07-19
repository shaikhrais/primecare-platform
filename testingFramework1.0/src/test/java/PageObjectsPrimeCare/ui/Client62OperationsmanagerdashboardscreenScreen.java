package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Client62OperationsmanagerdashboardscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 62;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_manager_dashboard-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_manager_dashboard-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_manager_dashboard-content')]")
	private WebElement primaryContent;

    public Client62OperationsmanagerdashboardscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Client62OperationsmanagerdashboardscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Client62OperationsmanagerdashboardscreenScreen", "/offices/franchise/roles/operations_manager/dashboard");
    }
}
