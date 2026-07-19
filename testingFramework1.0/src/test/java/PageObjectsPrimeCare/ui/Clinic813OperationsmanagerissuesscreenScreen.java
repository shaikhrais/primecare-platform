package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic813OperationsmanagerissuesscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 813;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_manager_issues-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_manager_issues-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_manager_issues-content')]")
	private WebElement primaryContent;

    public Clinic813OperationsmanagerissuesscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic813OperationsmanagerissuesscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic813OperationsmanagerissuesscreenScreen", "/offices/franchise/roles/operations_manager/issues");
    }
}
