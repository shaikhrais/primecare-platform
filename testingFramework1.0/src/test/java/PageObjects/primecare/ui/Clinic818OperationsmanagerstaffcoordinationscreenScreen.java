package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic818OperationsmanagerstaffcoordinationscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 818;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_manager_staff_coordination-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_manager_staff_coordination-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_manager_staff_coordination-content')]")
	private WebElement primaryContent;

    public Clinic818OperationsmanagerstaffcoordinationscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic818OperationsmanagerstaffcoordinationscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic818OperationsmanagerstaffcoordinationscreenScreen", "/offices/franchise/roles/operations_manager/staff-coordination");
    }
}

