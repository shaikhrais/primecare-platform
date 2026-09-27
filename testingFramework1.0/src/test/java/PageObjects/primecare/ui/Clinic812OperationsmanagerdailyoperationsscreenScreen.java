package pageobjects.primecare.ui;
 
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;
import base.baseTest;
 
public class Clinic812OperationsmanagerdailyoperationsscreenScreen extends baseTest {
 
    public static final int SCREEN_ID = 812;
 
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_manager_daily_operations-screen')]")
	private WebElement screenRoot;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_manager_daily_operations-title')]")
	private WebElement pageTitle;
	@FindBy(xpath = "//*[starts-with(@aria-label, 'operations_manager_daily_operations-content')]")
	private WebElement primaryContent;

    public Clinic812OperationsmanagerdailyoperationsscreenScreen() {
        PageFactory.initElements(driver, this);
    }
 
    public Clinic812OperationsmanagerdailyoperationsscreenScreen(org.openqa.selenium.WebDriver driver) {
        PageFactory.initElements(driver, this);
    }
 
    public boolean isLoaded() {
        return verifyNavigationProtocol(SCREEN_ID, "Clinic812OperationsmanagerdailyoperationsscreenScreen", "/offices/franchise/roles/operations_manager/daily-operations");
    }
}

