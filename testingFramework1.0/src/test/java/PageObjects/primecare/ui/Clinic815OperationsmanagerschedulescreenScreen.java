package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic815OperationsmanagerschedulescreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 815;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_manager_schedule-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_manager_schedule-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_manager_schedule-content')]")
	private WebElement primaryContent;

    public Clinic815OperationsmanagerschedulescreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic815OperationsmanagerschedulescreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic815OperationsmanagerschedulescreenScreen", "/offices/franchise/roles/operations_manager/schedule");
    }
}

