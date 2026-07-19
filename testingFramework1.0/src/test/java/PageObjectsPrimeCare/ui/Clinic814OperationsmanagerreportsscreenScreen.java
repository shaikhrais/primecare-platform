package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic814OperationsmanagerreportsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 814;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_manager_reports-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_manager_reports-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_manager_reports-content')]")
	private WebElement primaryContent;

    public Clinic814OperationsmanagerreportsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic814OperationsmanagerreportsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic814OperationsmanagerreportsscreenScreen", "/offices/franchise/roles/operations_manager/reports");
    }
}
