package PageObjectsPrimeCare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic811OperationsmanagerattendancescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 811;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_manager_attendance-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_manager_attendance-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_manager_attendance-content')]")
	private WebElement primaryContent;

    public Clinic811OperationsmanagerattendancescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic811OperationsmanagerattendancescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic811OperationsmanagerattendancescreenScreen", "/offices/franchise/roles/operations_manager/attendance");
    }
}
