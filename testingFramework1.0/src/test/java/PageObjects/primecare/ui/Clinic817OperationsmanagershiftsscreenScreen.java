package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic817OperationsmanagershiftsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 817;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_manager_shifts-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_manager_shifts-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_manager_shifts-content')]")
	private WebElement primaryContent;

    public Clinic817OperationsmanagershiftsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic817OperationsmanagershiftsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic817OperationsmanagershiftsscreenScreen", "/offices/franchise/roles/operations_manager/shifts");
    }
}

